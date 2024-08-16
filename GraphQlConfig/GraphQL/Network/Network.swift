//
//  Network.swift
//  RocketReserver
//
//  Created by Ellen Shapiro on 10/3/21.
//  Copyright © 2021 Apollo GraphQL. All rights reserved.
//

import Foundation
import Apollo

//MARK:- API Constant
struct APIConstant {
    static let parseErrorDomain = "ParseError"
    static let parseErrorMessage = "Unable to parse data"
    static let parseErrorCode = Int(UInt8.max)
    static let content_type = "Content-Type"
    static let platform_type = "Platform"
    static let device_type = "Device-Type"
    static let Authorization = "Authorization"
    static let content_value_urlencoded = "application/x-www-form-urlencoded"
    static let content_value_Json = "application/json"
    static let content_value_Form_Data = "multipart/form-data"
    static let Version = "Version"
    
    
    static let platform = "iOS"
    static let timezoneUTC = "UTC"
    static let languageCode = "lang-code"
}

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        
        let url = URL(string: "https://shifts2go.demo.brainvire.dev/graphql")!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

// MARK: Private Method(s)
extension Network {
    
    private func parseValidationErrors(errors:[String:Any]) -> SGError {
        if errors["category"] as? String == "validation"{
            var validationMessage = ""
            
            if let errorCategory = errors["validation"] as? [String:Any]{
                for key in errorCategory.keys
                {
                    if let errorValue = errorCategory[key] as? [String]{
                        if !validationMessage.isEmpty{
                            validationMessage += ", "
                        }
                        validationMessage = validationMessage + (errorValue.first ?? "")
                    }
                }
            }
            
            let errorObj = SGError.init(errorMessage: validationMessage, errorCode: 202)
            
            return errorObj
        }
        else if errors["category"] as? String == "authentication"{
            let errorObj = SGError.init(errorMessage: "Session expired. Please login again", errorCode: 401)
//            APPLICATION.appDelegate.prepareForLogout()
//            Alert.shared.showAlert(title: ValidationMessage.appName, message: errorObj.errorMessage)
            return errorObj
        }
        else if errors["category"] as? String == "Custom"{
            if let meta = errors["meta"] as? [String: Any] {
                let errorObj = SGError.init(errorMessage: (meta["message"] as? String ?? ""), errorCode: 202)
                return errorObj
            }
            return SGError(errorMessage: "Something Went Wrong", errorCode: 303)
        }
        else{
            return SGError(errorMessage: "Something Went Wrong", errorCode: 303)
        }
    }
}

// MARK: Public Method(s)
extension Network {
    
    public func callMutationApi<model:GraphQLMutation>(param: model,
                                                          publishResultToStore: Bool = false,
                                                          queue: DispatchQueue = .main ,
                                                          SuccessBlock:@escaping (GraphQLResult<model.Data>) -> Void,
                                                          FailureBlock:@escaping (SGError)-> Void) {
        ///Show loader
//        if isShowLoader {
//            Loader.shared.showSpinner()
//        }
        ///Check internet connection
        if !(NetworkReachabiliy.shared.isConnectedToNetwork) {
//            Alert.shared.showAlert(title: localized.kNetwork, message: localized.kNetworkMsg)
//            if isShowLoader {
//                Loader.shared.hideSpinner()
//            }
            return
        }
        print( "============ \(param)====================== ")
        print("Request /n \(String(describing: param.__variables))")
        self.apollo.perform(mutation: param, publishResultToStore: publishResultToStore, queue: queue, resultHandler: { result in
            print("===================Response============\n")
            ///Hide loader
//            if isShowLoader {
//                Loader.shared.hideSpinner()
//            }
//            dprint(items: "response /n \(result)")
            switch result {
            case .failure(let error):
                print("===================Failed! Result============\n")
                print("\(error.localizedDescription)")
                let errorObj = SGError.init(errorMessage: error.localizedDescription, errorCode: 202)
                
                FailureBlock(errorObj)
                
            case .success(let graphQLResult):
                
                if let errors = graphQLResult.errors {
                    print("===================Failed! Result============\n")
                    print("\(errors)")
                    if let errorObj = errors.first{
                        if let errorCategory = errorObj.extensions{
                            let errorObj =  self.parseValidationErrors(errors: errorCategory)
                            FailureBlock(errorObj)
                        }
                    }
                }
                else{
                    print("===================Success! Result============\n")
                    print("\(String(describing: graphQLResult.data?.__data._data as? NSDictionary))")
                    SuccessBlock(graphQLResult)
                }
            }
        })
    }
    
    
    public func callQueryAPI<model:GraphQLQuery>(model: model,
                                                    successBlock:@escaping (GraphQLResult<model.Data>) -> Void,
                                                    failureBlock:@escaping (SGError)-> Void){
//        ///Show loader
//        if isShowLoader {
//            Loader.shared.showSpinner()
//        }
        ///Check internet connection
        if !(NetworkReachabiliy.shared.isConnectedToNetwork) {
//            Alert.shared.showAlert(title: localized.kNetwork, message: localized.kNetworkMsg)
//            if isShowLoader {
//                Loader.shared.hideSpinner()
//            }
            return
        }
        print( "============ \(model)====================== ")
        print( "Request /n \(String(describing: model.__variables))")
        
        self.apollo.fetch(query: model, cachePolicy: .fetchIgnoringCacheCompletely) {
            result in
            ///Hide loader
//            if isShowLoader {
//                Loader.shared.hideSpinner()
//            }
            switch result {
            case .failure(let error):
                print( "===================Failed! Result============\n")
                print("\(error.localizedDescription)")
                let errorObj = SGError.init(errorMessage: error.localizedDescription, errorCode: 202)
                failureBlock(errorObj)
                break;
            case .success(let graphQLResult) :
                if let errors = graphQLResult.errors {
                    print("===================Failed! Result============\n")
                    print("\(errors)")
                    if let errorObj = errors.first{
                        if let errorCategory = errorObj.extensions{
                            print("\(errors)")
                            let errorObj =  self.parseValidationErrors(errors: errorCategory)
                            failureBlock(errorObj)
                        }
                    }
                }
                else{
                    print("===================Success! Result============\n")
                    print("\(String(describing: graphQLResult.data?.__data._data as? NSDictionary))")
                    successBlock(graphQLResult)
                }
                
            }
        }
    }
}
