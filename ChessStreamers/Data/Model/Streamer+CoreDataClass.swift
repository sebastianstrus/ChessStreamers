//
//  Streamer+CoreDataClass.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//
//


import Foundation
import CoreData

@objc(Streamer)
public class Streamer: NSManagedObject, Decodable {
    
    @NSManaged public var username: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var isLive: Bool
    
    enum CodingKeys: String, CodingKey {
        case username
        case avatarUrl = "avatar"
        case url
        case isLive = "is_live"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
              throw DecoderConfigurationError.missingManagedObjectContext
            }

            self.init(context: context)
        
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.url = try container.decode(String.self, forKey: .url)
        self.isLive = try container.decode(Bool.self, forKey: .isLive)
        
    }
    
}

extension Streamer: Encodable{
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.username, forKey: .username)
        try container.encode(self.avatarUrl, forKey: .avatarUrl)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.isLive, forKey: .isLive)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}
extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
