//
//  AuthenticationManager.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

protocol AuthenticationManagerDelegate {
    func didUpdateData(_ authenticationManager: AuthenticationManager, data: AuthenticationResponse)
    func didFailWithError(error: Error)
    func didReceiveToken(token: String)
}

struct AuthenticationManager {
    var delegate: AuthenticationManagerDelegate?
}
