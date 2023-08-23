//
//  DrinkDataManager.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

protocol DrinkDataManagerDelegate {
    func didReceiveDrinkData(_ drinkDataManager: DrinkDataManager, drinkDataResponse: DrinkDataResponse)
    func didUpdateDrinkData(_ drinkDataManager: DrinkDataManager, drinkDataResponse: DrinkDataResponse)
    func didFailWithError(error: Error)
}
struct DrinkDataManager {
    let drinkDataBackendUrl = "\(Constant.App.backendUrl)data"
    var delegate: DrinkDataManagerDelegate?
    
    func getDrinkData(token: String) {
        if let backendUrl = URL(string: drinkDataBackendUrl) {
            var request = URLRequest(url: backendUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: Constant.App.authenticationHeader)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: getCompletionHandler)
            task.resume()
        }
    }
    
    func updateDrinkData(drinkDataRequest: DrinkDataRequest, token: String) {
        if let backendUrl = URL(string: drinkDataBackendUrl) {
            var request = URLRequest(url: backendUrl)
            request.httpMethod = "PUT"
            request.httpBody = JSONToDataConverter(json: drinkDataRequest)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: Constant.App.authenticationHeader)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: updateCompletionHandler)
            task.resume()
        }
    }
    
    func updateCompletionHandler(data: Data?, response: URLResponse?, error: Error?) {
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }
        
        if let safeData = data {
            if let drinkDataResponse = dataToJSONConverter(data: safeData) {
                delegate?.didUpdateDrinkData(self, drinkDataResponse: drinkDataResponse)
            }
        }
    }
    
    func getCompletionHandler(data: Data?, response: URLResponse?, error: Error?) {
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }
        
        if let safeData = data {
            if let drinkDataResponse = dataToJSONConverter(data: safeData) {
                delegate?.didReceiveDrinkData(self, drinkDataResponse: drinkDataResponse)
            }
        }
    }
    
    func JSONToDataConverter(json: DrinkDataRequest) -> Data? {
        let encoder = JSONEncoder()
        do {
            let drinkDataRequest = try encoder.encode(json)
            return drinkDataRequest
        } catch {
            return nil
        }
    }
    
    func dataToJSONConverter(data: Data) -> DrinkDataResponse? {
        let decoder = JSONDecoder()
        do {
            let drinkDataResponse = try decoder.decode(DrinkDataResponse.self, from: data)
            return drinkDataResponse
        } catch {
            return nil
        }
    }
    
}
