//
//  GeneralError.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit

public enum GeneralError: Error, CustomStringConvertible, LocalizedError
{
    case unknown
    case invalidAddress

    
    public var description: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidAddress:
            return "Incorrect address"
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidAddress:
            return "Invalid address"
        }
    }
}
