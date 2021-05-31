//
//  RaffleDetailController.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

class RaffleDetailController: UIViewController {

    let detailView = RaffleDetailView()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section,Participant>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,Participant>
    
    private var collectionView: UICollectionView! = nil
    
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
//        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.backgroundColor = .systemBackground
        detailView.delegate = self
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        loadParticipants()
    }
    
    private func loadParticipants() {
        APIClient.fetchRaffleParticipants(for: 34) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let participants):
                dump(participants)
                self.applySnapshot(participants: participants)
            }
        }
    }
    
}

extension RaffleDetailController {
    
    enum Section {
        case main
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: detailView.contentContainer.bounds, collectionViewLayout: CVLayout.createCVLayout(insetVert: 8, insetHor: 8, height: 200))
//        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemTeal
        collectionView.register(ParticipantCell.self, forCellWithReuseIdentifier: ParticipantCell.reuseIdentifier)
        
//        let sView = RegisterView()

        detailView.contentContainer.addSubview(collectionView)
        
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, participant) -> ParticipantCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipantCell.reuseIdentifier, for: indexPath) as? ParticipantCell else {
                fatalError("Dequeing raffle cell error")
            }
            cell.configureCell(participant)
            return cell
        })
    }
    
    private func applySnapshot(participants: [Participant]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(participants)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


extension RaffleDetailController: DetailViewDelegate {
    func handleSegController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("participants")
            registerView.removeFromSuperview()
            detailView.contentContainer.addSubview(collectionView)
        case 1:
//            let sView = RegisterView()
            collectionView.removeFromSuperview()
            detailView.contentContainer.addSubview(registerView)
            print("register")
        default:
            print("winner")
        }
    }
    
    func handleDismiss() {
        self.dismiss(animated: true)
    }
}

struct CVLayout {
    static func createCVLayout(insetVert: CGFloat, insetHor: CGFloat, height: CGFloat) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: insetVert, leading: insetHor, bottom: insetVert, trailing: insetHor)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
