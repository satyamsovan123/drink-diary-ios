//
//  DrinkDataManager.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

protocol DrinkDataManagerDelegate {
    func didUpdateData(_ drinkDataManager: DrinkDataManager, data: DrinkDataResponse)
    func didFailWithError(error: Error)
}
struct DrinkDataManager {
    var delegate: DrinkDataManagerDelegate?
}
