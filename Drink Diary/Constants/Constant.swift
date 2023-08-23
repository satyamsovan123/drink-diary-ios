//
//  Constants.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 21/08/23.
//

import Foundation

struct Constant {
    struct App {
        static let backendUrl = "https://drink-diary-server.onrender.com/api/"
        // static let backendUrl = "http://localhost:3000/api/"
        static let webFrontendUrl = "https://drink-diary-web.web.app"
        static let authenticationHeader = "Authorization"
    }
    
    struct Common {
        static let error = "Something went wrong. Please try again later."
        static let success = "Successful."
        static let helpLabel = "Elevate your beverage consumption monitoring with Drink Diary app. Embrace a free and seamless journey by signing up to effortlessly track your beverage choices. Accessible via both web (\(App.webFrontendUrl)) and iOS app, our user-friendly interface ensures you're always aligned with your goals. Watch as your drink data gracefully resets at midnight, ready to kickstart your day anew. You have the power to erase your data or your account whenever you choose. Enhance your daily routine with a touch of elegance and practicality."
        static let deleteAccountLabel = "We are sorry, but to delete your account or data, you need to use our website - '\(App.webFrontendUrl)/help'. The developer doesn't want to develop this feature here because they don't have the time."
    }
    
    struct AuthenticationMessage {
        static let invalidEmail = "Please provide a valid email."
        static let invalidPassword = "Please provide a valid password."
        static let signinSuccessfulMessage = "You are now signed in."
        static let signupSuccessfulMessage = "You are now signed up."
        
        static let unauthorized = "We are sorry, but we need you to sign in again."
    }
    
    struct DrinkDataMessage {
        static let invalidTotalDrinks = "Please provide valid numbers of total drinks."
        static let invalidBeverageName = "Please provide a valid beverage name."
        static let drinkDataReceivedSuccessfulMessage = "Your data was retrived successfully."
        static let drinkDataAddedSuccessfulMessage = "Your data was added successfully."
        static let drinkDataUpdatedSuccessfulMessage = "Your data was updated successfully."
    }
}
