//
//  SGError.swift
//  Shift2Go
//
//  Created by Vivek Bhoraniya on 30/08/22.
//

import Foundation

class SGError: Error {
    
    let errorMessage:String?
    let errorCode:Int?
    
    init(errorMessage:String?, errorCode:Int?){
        self.errorMessage = errorMessage
        self.errorCode = errorCode
    }
    
}
