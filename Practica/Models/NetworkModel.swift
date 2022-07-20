//
//  NetworkModel.swift
//  Practica
//
//  Created by Nicolas on 13/07/22.
//

import Foundation

final class NetworkModel {
    
    private var token: String?
      
    static let shared = NetworkModel()
      
    private init() {}
    
    func getToken() -> String {
        return self.token ?? ""
    }
    
    private func networkCall(
        uri: String,
        method: String,
        authentication: String,
        credentials: String,
        jsonRequest: Bool,
        body: Data?,
        completion: @escaping (Data?, NetworkError?) -> Void
    ) {
        
        guard let url = URL(string: uri) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("\(authentication) \(credentials)", forHTTPHeaderField: "Authorization")
        
        if jsonRequest {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(nil, NetworkError.errorResponse)
                return
            }
          
            if let httpResponse = (response as? HTTPURLResponse) {
                if httpResponse.statusCode == 401 {
                    completion(data, NetworkError.notAuthenticated)
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    completion(data, NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                    return
                }
            }
            
            completion(data, nil)
            
        }
        
        task.resume()
    }
    
    func login(user: String, password: String, completion: @escaping (String?) -> Void) {
        
        //let loginString = user + ":" + password
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
          completion("Internal Error")
          return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        networkCall(
            uri: ApiURL.LOGIN,
            method: "POST",
            authentication: "Basic",
            credentials: base64LoginString,
            jsonRequest: false,
            body: nil) { data, error in
                
                guard error == nil else {
                    switch error.unsafelyUnwrapped {
                        case .notAuthenticated:
                            LocalDataModel.deleteEmail()
                            completion("Invalid Credentials")
                        default:
                            completion("Network Error")
                    }
                    
                    return
                }
              
                guard let data = data else {
                    completion("Network Error Response")
                    return
                }
                
                guard let token = String(data: data, encoding: .utf8) else {
                    completion("Internal Error")
                return
                }
            
                self.token = token
                LocalDataModel.save(email: user)
                completion(nil)
            }
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], String?) -> Void) {
        
        struct Body: Encodable {
          let name: String
        }
        
        let body = try? JSONEncoder().encode(Body(name: name))
        
        networkCall(
            uri: ApiURL.HEROS_ALL,
            method: "POST",
            authentication: "Bearer",
            credentials: getToken(),
            jsonRequest: true,
            body: body) { data, error in
                
                guard error == nil else {
                    completion([],"Network Error")
                    return
                }
              
                guard let data = data else {
                    completion([],"Network Error Response")
                    return
                }
                
                guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                  completion([], "Internal Error")
                  return
                }
                let response = heroesResponse.sorted(by: { $0.name < $1.name })
                completion(response, nil)
            }
    }
    
    func getTransformations(id: String, completion: @escaping ([Transformation], String?) -> Void) {
        
        struct Body: Encodable {
          let id: String
        }
        
        let body = try? JSONEncoder().encode(Body(id: id))
        
        networkCall(
            uri: ApiURL.HEROS_TRANSFORMATION,
            method: "POST",
            authentication: "Bearer",
            credentials: getToken(),
            jsonRequest: true,
            body: body) { data, error in
                
                guard error == nil else {
                    completion([],"Network Error")
                    return
                }
              
                guard let data = data else {
                    completion([],"Network Error Response")
                    return
                }
                
                guard let heroesResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                  completion([], "Internal Error")
                  return
                }
                let response = heroesResponse.sorted(by: { $0.name < $1.name })
                completion(response, nil)
            }
    }
    
}
