//
//  AuthenticationModel.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

struct AuthenticationRequest: Codable {
    let email: String
    let password: String
}

struct AuthenticationResponse: Codable {
    let data: EmptyData
    let message: String
}

struct EmptyData: Codable {
    
}

