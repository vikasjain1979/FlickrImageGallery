//
//  StartShipError.swift
//  StarShip
//
//  Created by Jain, Vikas on 29/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import Foundation

// This protocol can be used to specify custom message and title for different error codes.
protocol ErrorMessageProviding {
    var alertTitle: String { get }
    var alertMessage: String { get }
}

public enum APIError: Error {
    // MARK: - Error Codes
    // Can add more codes here e.g. 4XX, 5XX or business specifc error codes
    case serviceUnavailable
    case responseDecodingError
}

extension APIError: ErrorMessageProviding {
    var alertTitle: String {
        switch self {
        case .serviceUnavailable:
            return "Service Unavailable"
        case .responseDecodingError:
            return "Something Went Wrong"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .serviceUnavailable:
            return "There seems to be some problem in contacting the server. Please try again later."
        case .responseDecodingError:
            return "Something Went Wrong"
        }
    }
}


