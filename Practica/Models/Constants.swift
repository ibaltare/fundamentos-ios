//
//  Constants.swift
//  Practica
//
//  Created by Nicolas on 13/07/22.
//

import Foundation

final class ApiURL {
    
    static let LOGIN = "https://vapor2022.herokuapp.com/api/auth/login"
    
    static let HEROS_ALL = "https://vapor2022.herokuapp.com/api/heros/all"
    
    static let HEROS_TRANSFORMATION = "https://vapor2022.herokuapp.com/api/heros/tranformations"
    
    private init() {}
}

enum NetworkError: Error {
    case malformedURL
    case errorResponse
    case errorCode(Int?)
    case notAuthenticated
}
