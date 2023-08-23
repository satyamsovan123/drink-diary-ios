//
//  AuthenticationManager.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

protocol AuthenticationManagerDelegate {
    func didCompleteAuthentication(_ authenticationManager: AuthenticationManager, authenticationResponse: AuthenticationResponse)
    func didFailWithError(error: Error)
    func didReceiveToken(_ authenticationManager: AuthenticationManager, token: String)
}

struct AuthenticationManager {
    var delegate: AuthenticationManagerDelegate?
    
    func performBackendRequest(authenticationRequest: AuthenticationRequest, action: String) {
        var authenticationBackendUrl = ""
        switch (action) {
        case "signin":
            authenticationBackendUrl = "\(Constant.App.backendUrl)signin"
        case "signup":
            authenticationBackendUrl = "\(Constant.App.backendUrl)signup"
        default:
            authenticationBackendUrl = ""
        }
        
        if let backendUrl = URL(string: authenticationBackendUrl) {
            var request = URLRequest(url: backendUrl)
            request.httpMethod = "POST"
            request.httpBody = JSONToDataConverter(json: authenticationRequest)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    func completionHandler(data: Data?, response: URLResponse?, error: Error?) {
        var token = ""
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }
        
        if let safeResponse = response {
            if let rawToken = (safeResponse as! HTTPURLResponse).value(forHTTPHeaderField: Constant.App.authenticationHeader) {
                token = rawToken.components(separatedBy: " ")[1]
                delegate?.didReceiveToken(self, token: token)
            }
        }
        
        if let safeData = data {
            if let authenticationResponse = dataToJSONConverter(data: safeData) {
                delegate?.didCompleteAuthentication(self, authenticationResponse: authenticationResponse)
            }
        }
    }
    
    func JSONToDataConverter(json: AuthenticationRequest) -> Data? {
        let encoder = JSONEncoder()
        do {
            let authenticationRequest = try encoder.encode(json)
            return authenticationRequest
        } catch {
            return nil
        }
    }
    
    func dataToJSONConverter(data: Data) -> AuthenticationResponse? {
        let decoder = JSONDecoder()
        do {
            let authenticationResponse = try decoder.decode(AuthenticationResponse.self, from: data)
            return authenticationResponse
        } catch {
            return nil
        }
    }
}
