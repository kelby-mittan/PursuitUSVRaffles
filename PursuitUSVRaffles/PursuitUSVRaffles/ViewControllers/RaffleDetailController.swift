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
        view.delegate = self
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
    
    private var firstname = ""
    private var lastname = ""
    private var email = ""
    private var phone = ""
    
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
        setupTextFieldDelegates()
    }
    
    private func setupTextFieldDelegates() {
        registerView.nameTextField.delegate = self
        registerView.emailTextField.delegate = self
        registerView.phoneTextField.delegate = self
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
//            registerView.removeFromSuperview()
//            winnerView.removeFromSuperview()
//            pickWinnerView.removeFromSuperview()
//            detailView.contentContainer.addSubview(collectionView)
            loadCollectionView()
        case 1:
            winnerView.removeFromSuperview()
            pickWinnerView.removeFromSuperview()
            handleAWinner(registerView)
        default:
            registerView.removeFromSuperview()
            handleAWinner(pickWinnerView)
        }
    }
    
    func loadCollectionView() {
        detailView.nameLabel.text = raffle.name
        registerView.removeFromSuperview()
        winnerView.removeFromSuperview()
        pickWinnerView.removeFromSuperview()
        detailView.contentContainer.addSubview(collectionView)
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

extension RaffleDetailController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setRegisterText(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setRegisterText(textField: textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setRegisterText(textField: textField)
    }
    
    func setRegisterText(textField: UITextField) {
        switch textField {
        case registerView.nameTextField:
            let nameText = textField.text ?? ""
            if nameText.contains(" ") {
                firstname = nameText.components(separatedBy: " ").first ?? ""
                lastname = nameText.components(separatedBy: " ").last ?? ""
            }
        case registerView.emailTextField:
            email = textField.text ?? ""
        case registerView.phoneTextField:
            phone = textField.text ?? ""
        default:
            print("helllloooo")
        }
    }
}

extension RaffleDetailController: RegisterDelegate {
    func handleRegistration() {
        
//        if !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty {
//            let participant = ParticipantPost(firstname: firstname, lastname: lastname, email: email, phone: phone)
//            guard let id = raffle.id else { return }
//            APIClient.postParticipant(for: participant, with: id) { result in
//                switch result {
//                case .failure(let error):
//                    print(error.localizedDescription)
//                case .success(let passed):
//                    print(passed)
//                    DispatchQueue.main.async {
//                        self.loadParticipants()
//                        UIView.animate(withDuration: 1.5) {
//                            self.registerView.successView.alpha = 1
//                        }
//                    }
//                }
//            }
            
//            registerView.nameTextField.text = ""
//            registerView.emailTextField.text = ""
//            registerView.phoneTextField.text = ""
//
//        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5) {
                self.registerView.successView.alpha = 1
            }
        }
        
    }
    
}

