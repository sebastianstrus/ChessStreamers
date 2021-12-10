//
//  Properties.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import Foundation

enum ServerEnvironment: String {
    case dev = "https://api.chess.com_temp"// added '_temp' just to make it unique for now
    case prod = "https://api.chess.com"
}

class Properties  {
    static var environment: ServerEnvironment {
        #if DEBUG
        //return .dev
        return .prod
        #else
        return .prod
        #endif
    }
}
