//
//  PursuitUSVRafflesTests.swift
//  PursuitUSVRafflesTests
//
//  Created by Kelby Mittan on 5/29/21.
//

import XCTest
@testable import PursuitUSVRaffles

class PursuitUSVRafflesTests: XCTestCase {
    
    func testFetchingRaffles() {
        let expected = 31
        let exp = XCTestExpectation(description: "Test")
        APIClient.fetchRaffles { (result) in
            switch result {
            case .failure(let error):
                XCTFail("Failed Test \(error)")
            case .success(let raffles):
                let rafflesID = raffles[0].id
                dump(raffles)
                XCTAssertEqual(rafflesID, expected)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }
    
//    func testFetchingRaffleParticipants() {
//        let expected = "rose"
//        let exp = XCTestExpectation(description: "Test Rose")
//        APIClient.fetchRaffleParticipants(for: 34) { (result) in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed Test \(error)")
//            case .success(let participants):
//                let participantLastName = participants[1].lastname
//                dump(participants)
//                XCTAssertEqual(participantLastName, expected)
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 4.0)
//    }
    
//    func testFetchingRaffleToken() {
//        let expected = "test123"
//        let exp = XCTestExpectation(description: "Test Rose")
//        APIClient.fetchWinnerId(for: 34) { (result) in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed Test \(error)")
//            case .success(let participants):
//                let participantLastName = participants.description
//                dump(participants)
//                XCTAssertEqual(participantLastName, expected)
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 4.0)
//    }
    
//    func testPostingRaffle() {
//        let raffle = RafflePost(name: "Puppy Dog Raffle", secretToken: "puppy123")
//        let exp = XCTestExpectation(description: "Post Test")
//        APIClient.postRaffle(for: raffle) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed Test \(error.localizedDescription)")
//            case .success(let passed):
//                XCTAssertTrue(passed, "Successfull Post")
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 3.0)
//    }
    
//    func testPutWinner() {
//        let token = SecretToken(secretToken: "lol123")
//        let exp = XCTestExpectation(description: "Put Test")
//        APIClient.putWinnerRequest(for: token, with: 118) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed Test \(error.localizedDescription)")
//            case .success(let participant):
//                XCTAssertEqual("stevejobs", participant.firstname)
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 3.0)
//    }
    
//    func testPostingParticipant() {
//        let participant = ParticipantPost(firstname: "scooby", lastname: "doo", email: "scoobs@ruff.com", phone: "")
//        let exp = XCTestExpectation(description: "Post Test")
//        APIClient.postParticipant(for: participant, with: 85) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("Failed Test \(error.localizedDescription)")
//            case .success(let passed):
//                XCTAssertTrue(passed, "Successfull Post")
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 3.0)
//    }
    
    
}
