//
//  Device.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import Foundation
import UIKit

struct Device {
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
}
