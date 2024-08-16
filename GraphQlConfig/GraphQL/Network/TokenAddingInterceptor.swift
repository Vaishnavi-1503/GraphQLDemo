import Foundation
import Apollo



class TokenAddingInterceptor: ApolloInterceptor {
    var id: String = UUID().uuidString

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            
            request.addHeader(name: APIConstant.platform_type, value: APIConstant.platform)
            // add langauge code in header
//            request.addHeader(name: APIConstant.languageCode, value: AppShared.shared.appLanguageCode)
            // add time zone region
//            request.addHeader(name: APIConstant.timeZoneRegion, value: TimeZone.current.identifier)
            
            // add access token
            if let token = access_token, !(token.isEmpty) {
                request.addHeader(name: APIConstant.Authorization, value: "Bearer \(token)")
            }
            
            print("==================Header============")
            print("\(request)")
            
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion)
        }
}


var access_token : String? {
   get {
       let notificationCount = UserDefaults.standard.string(forKey: "accessToken")
       return notificationCount ?? ""
   }
   set {
       UserDefaults.standard.set(newValue, forKey: "accessToken")
       UserDefaults.standard.synchronize()
   }
}
