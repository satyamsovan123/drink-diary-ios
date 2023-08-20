//
//  DataModel.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import Foundation

struct DrinkDataResponse: Codable {
    let data: DrinkData
    let message: String
}

struct DrinkData: Codable {
    let email: String?
    let totalDrinks: Int?
    let beverageName: String?
}
