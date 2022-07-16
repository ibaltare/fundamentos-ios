//
//  Constants.swift
//  Practica
//
//  Created by Nicolas on 13/07/22.
//

import Foundation

final class ApiURL {
    
    static let LOGIN = "https://vapor2022.herokuapp.com/api/auth/login"
    
    private init() {}
}

enum NetworkError: Error {
    case malformedURL
    case errorResponse
    case errorCode(Int?)
    case notAuthenticated
    
    case dataFormatting
    case other
    case noData
    case tokenFormatError
    case decoding
}
