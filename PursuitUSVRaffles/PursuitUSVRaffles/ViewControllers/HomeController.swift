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
    
    private var raffleCreatedName = ""
    private var raffleToken = ""
    
    private lazy var popUpView: RafflePopUpView = {
        let view = RafflePopUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        homeView.createRaffleButton.addTarget(self, action: #selector(raffleButtonPressed), for: .touchUpInside)
        popUpView.nameTextField.delegate = self
        popUpView.tokenTextField.delegate = self
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        loadRaffles()
        setupVisualEffect()
        
    }
    
    private func loadRaffles() {
        APIClient.fetchRaffles { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let raffles):
                dump(raffles)
                self.applySnapshot(raffles: raffles)
            }
        }
    }
    
    private func setupVisualEffect() {
        homeView.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: homeView.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: homeView.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: homeView.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    @objc func raffleButtonPressed() {
        homeView.addSubview(popUpView)
        popUpView.centerYAnchor.constraint(equalTo: homeView.centerYAnchor, constant: -UIScreen.main.bounds.height/6).isActive = true
        popUpView.centerXAnchor.constraint(equalTo: homeView.centerXAnchor).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: homeView.frame.width-64).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: homeView.frame.width-64).isActive = true
        popUpView.backgroundColor = .white
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
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

extension HomeController: PopUpDelegate {
    
    func handleDismiss() {
        dismissPopUp()
    }
    
    func handleCreate() {
        print("create pressed \(raffleCreatedName) + \(raffleToken)")
        
        if !raffleCreatedName.isEmpty && !raffleToken.isEmpty {
            let newRaffle = RafflePost(name: raffleCreatedName, secretToken: raffleToken)
            APIClient.postRaffle(for: newRaffle) { result in
                switch result {
                case .failure(let error):
                    print("Error Posting Raffle \(error.localizedDescription)")
                case .success(let passed):
                    print(passed)
                    DispatchQueue.main.async {
                        self.dismissPopUp()
                    }
                }
            }
        }
        
    }
    
    func dismissPopUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpView.removeFromSuperview()
        }
    }
    
}

extension HomeController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("should return called")
        
//        if textField == popUpView.nameTextField {
//            raffleCreatedName = textField.text ?? ""
//        }
//        if textField == popUpView.tokenTextField {
//            raffleToken = textField.text ?? ""
//        }
        setNameAndToken(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == popUpView.nameTextField {
//            raffleCreatedName = textField.text ?? ""
//        }
//        if textField == popUpView.tokenTextField {
//            raffleToken = textField.text ?? ""
//        }
        setNameAndToken(textField: textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        if textField == popUpView.nameTextField {
//            raffleCreatedName = textField.text ?? ""
//        }
//        if textField == popUpView.tokenTextField {
//            raffleToken = textField.text ?? ""
//        }
        setNameAndToken(textField: textField)
    }
    
    func setNameAndToken(textField: UITextField) {
        if textField == popUpView.nameTextField {
            raffleCreatedName = textField.text ?? ""
        }
        if textField == popUpView.tokenTextField {
            raffleToken = textField.text ?? ""
        }
    }
}
