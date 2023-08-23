//
//  Helper.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 22/08/23.
//

import Foundation

struct CommonService {
    static var currentBackground = ""
    static func logger(_ data: Any) {
        print(data)
    }
    
    static func getBackground(_ beverageName: String) -> String {
        var background = ""
        switch (beverageName.lowercased()) {
        case "tea":
            background = "TeaBackground"
        case "coffee", "latte", "espresso", "cappuccino", "black coffee":
            background = "CoffeeBackground"
        case "water":
            background = "WaterBackground"
        case "beer":
            background = "BeerBackground"
        case "coke", "cola":
            background = "CarbonatedDrinkBackground"
        default:
            background = "DefaultBackground"
        }
        CommonService.currentBackground = background
    return background
    }

}
