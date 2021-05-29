//
//  HomeController.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
//        let apiClient = APIClient()
        APIClient.fetchRaffleParticipants(for: 34) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let raffles):
                dump(raffles)
                print(raffles.count)
            }
        }
    }

}
