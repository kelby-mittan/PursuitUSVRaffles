//
//  RaffleDetailController.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

class RaffleDetailController: UIViewController {

    let raffle: Raffle
    
    let detailView = RaffleDetailView()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section,Participant>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,Participant>
    
    private var collectionView: UICollectionView! = nil
    private var dataSource: DataSource!
    private var snapshot = DataSourceSnapshot()
    
    private var participants = [Participant]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        return view
    }()
    
    private lazy var winnerView: WinnerView = {
        let view = WinnerView()
        return view
    }()
    
    private lazy var pickWinnerView: PickWinnerView = {
        let view = PickWinnerView()
        return view
    }()
    
    init(_ raffle: Raffle) {
        self.raffle = raffle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        guard let id = raffle.id, let name = raffle.name else { return }
        detailView.nameLabel.text = name
        APIClient.fetchRaffleParticipants(for: id) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let participants):
                dump(participants)
                self.participants = participants
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
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemTeal
        collectionView.register(ParticipantCell.self, forCellWithReuseIdentifier: ParticipantCell.reuseIdentifier)
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
            detailView.nameLabel.text = raffle.name
            registerView.removeFromSuperview()
            winnerView.removeFromSuperview()
            pickWinnerView.removeFromSuperview()
            detailView.contentContainer.addSubview(collectionView)
        case 1:
            winnerView.removeFromSuperview()
            pickWinnerView.removeFromSuperview()
            handleAWinner(registerView)
        default:
            registerView.removeFromSuperview()
            handleAWinner(pickWinnerView)
        }
    }
    
    func handleDismiss() {
        self.dismiss(animated: true)
    }
    
    func handleAWinner(_ view: UIView) {
        collectionView.removeFromSuperview()
        let participant = participants.filter{$0.id == raffle.winnerID}.first
        if let winner = participant {
            winnerView.configureView(winner, raffle)
            detailView.contentContainer.addSubview(winnerView)
            detailView.nameLabel.text = "Winner id: \(participant?.id?.description ?? "")"
        } else {
            detailView.contentContainer.addSubview(view)
        }
    }
}

