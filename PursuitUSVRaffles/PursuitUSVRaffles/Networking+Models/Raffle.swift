//
//  Raffle.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import Foundation
import UIKit

struct Raffle: Decodable, Hashable {
    let id: Int?
    let name: String?
    let createdAt: String?
    let raffledAt: String?
    let winnerID: Int?
    let secretToken: String?
    
    var createdDate: Date {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime,
                                      .withFractionalSeconds
        ]
        let date = isoFormatter.date(from: createdAt ?? "")
        return date ?? Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case raffledAt = "raffled_at"
        case winnerID = "winner_id"
        case secretToken = "secret_token"
    }
}

struct RafflePost: Encodable {
    let name: String
    let secretToken: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case secretToken = "secret_token"
    }
}

struct SecretToken: Codable {
    let secretToken: String?
    
    enum CodingKeys: String, CodingKey {
        case secretToken = "secret_token"
    }
}
