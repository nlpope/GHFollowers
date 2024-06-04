//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/2/24.
//

import Foundation

//GFError has a raw value of a string and follows the Error protocol for the Result type it gets back
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}