//
//  APIClient.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import Foundation

struct APIClient {
    
    static func fetchRaffles(completion: @escaping (Result<[Raffle],AppError>) -> ()) {
        let endpointURLString = "https://raffle-fs-app.herokuapp.com/api/raffles/"
        guard let url = URL(string: endpointURLString) else {
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let raffles = try JSONDecoder().decode([Raffle].self, from: data)
                    completion(.success(raffles))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    static func postRaffle(for raffle: RafflePost, completion: @escaping (Result<Bool,AppError>) -> ()) {
        
        let postRaffleEndpoint = "https://raffle-fs-app.herokuapp.com/api/raffles"
        guard let url = URL(string: postRaffleEndpoint) else {
            return
        }
        do {
            let data = try JSONEncoder().encode(raffle)
            var request = URLRequest(url: url)
            request.httpMethod = "Post"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
                        
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func fetchRaffleParticipants(for id: Int, completion: @escaping (Result<[Participant],AppError>) -> ()) {
        let endpointURLString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/participants"
        guard let url = URL(string: endpointURLString) else {
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let participants = try JSONDecoder().decode([Participant].self, from: data)
                    completion(.success(participants))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    static func postParticipant(for participant: ParticipantPost, with id: Int, completion: @escaping (Result<Bool,AppError>) -> ()) {
        
        let postParticipantEndpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/participants"
        guard let url = URL(string: postParticipantEndpoint) else {
            return
        }
        do {
            let data = try JSONEncoder().encode(participant)
            var request = URLRequest(url: url)
            request.httpMethod = "Post"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
                        
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func putWinnerRequest(for token: SecretToken, with id: Int, completion: @escaping (Result<Participant,AppError>) -> ()) {
        
        let postParticipantEndpoint = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)/winner"
        guard let url = URL(string: postParticipantEndpoint) else {
            return
        }
        do {
            let data = try JSONEncoder().encode(token)
            var request = URLRequest(url: url)
            request.httpMethod = "Put"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
                        
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
//                    completion(.success(true))
                    do {
                        let participant = try JSONDecoder().decode(Participant.self, from: data)
                        completion(.success(participant))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
        
    static func fetchWinnerId(for id: Int, completion: @escaping (Result<Int,AppError>) -> ()) {
        let endpointURLString = "https://raffle-fs-app.herokuapp.com/api/raffles/\(id)"
        guard let url = URL(string: endpointURLString) else {
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let raffle = try JSONDecoder().decode(Raffle.self, from: data)
                    completion(.success(raffle.winnerID ?? 000))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}

