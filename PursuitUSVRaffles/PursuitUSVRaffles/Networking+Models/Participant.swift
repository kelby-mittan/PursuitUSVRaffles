//
//  Participant.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import Foundation

/*
         "id": 29,
         "raffle_id": 34,
         "firstname": "julius",
         "lastname": "randle",
         "email": "knicks@gmail.com",
         "phone": null,
         "registered_at": "2021-05-28T19:35:16.901Z"
 */

struct Participant: Decodable, Hashable {
    let id: Int?
    let raffleID: Int?
    let firstname: String?
    let lastname: String?
    let email: String?
    let phone: String?
    let registeredAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case raffleID = "raffle_id"
        case firstname
        case lastname
        case email
        case phone
        case registeredAt = "registered_at"
    }
}

struct ParticipantPost: Encodable {
    let firstname: String
    let lastname: String
    let email: String
    let phone: String
}
