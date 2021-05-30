//
//  HomeController.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class HomeController: UIViewController {
    
    let homeView = HomeView()
    
    var raffles = [Raffle]() {
        didSet {
            DispatchQueue.main.async {
                self.homeView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        
        loadRaffles()
    }
    
    private func loadRaffles() {
        APIClient.fetchRaffles { (result) in
            switch result {
            case .failure(let error):
                // TODO: Error loading raffles alert
                print(error.localizedDescription)
            case .success(let raffles):
                dump(raffles)
                self.raffles = raffles
//                let d = raffles.first!.createdAt!
//                print(d.date().toString())
//                print(d.date().toString(format: "h:mm a"))
            }
        }
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width*5/6, height: homeView.collectionView.frame.height*1/3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return raffles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "raffleCell", for: indexPath) as! RaffleCell
        cell.backgroundColor = .green
        let raffle = raffles[indexPath.row]
        cell.configureCell(raffle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let raffle = raffles[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let verticalSpace = view.frame.height / 5
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
