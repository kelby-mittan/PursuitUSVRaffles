//
//  HomeController.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class HomeController: UIViewController {
    
    let homeView = HomeView()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section,Raffle>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,Raffle>
    
    private var collectionView: UICollectionView! = nil
    
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
//    var raffles = [Raffle]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.homeView.collectionView.reloadData()
//            }
//        }
//    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
//        homeView.collectionView.delegate = self
//        homeView.collectionView.dataSource = self
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
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
                self.applySnapshot(raffles: raffles)
//                self.raffles = raffles
//                let d = raffles.first!.createdAt!
//                print(d.date().toString())
//                print(d.date().toString(format: "h:mm a"))
            }
        }
    }
    
    
    
}

extension HomeController {
    
    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: homeView.cvContainerView.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemTeal
        collectionView.register(RaffleCell.self, forCellWithReuseIdentifier: RaffleCell.reuseIdentifier)
        homeView.cvContainerView.addSubview(collectionView)
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, raffle) -> RaffleCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RaffleCell.reuseIdentifier, for: indexPath) as? RaffleCell else {
                fatalError("Dequeing raffle cell error")
            }
            cell.configureCell(raffle)
            return cell
        })
    }
    
    private func applySnapshot(raffles: [Raffle]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(raffles)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let raffle = dataSource.itemIdentifier(for: indexPath) else { return }
        print(raffle.name ?? "")
    }
}

//extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: UIScreen.main.bounds.size.width*5/6, height: homeView.collectionView.frame.height*1/3)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return raffles.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "raffleCell", for: indexPath) as! RaffleCell
//        cell.backgroundColor = .green
//        let raffle = raffles[indexPath.row]
//        cell.configureCell(raffle)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let raffle = raffles[indexPath.row]
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////        let verticalSpace = view.frame.height / 5
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//}
