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
        
        homeView.createRaffleButton.addTarget(self, action: #selector(raffleButtonPressed), for: .touchUpInside)
        popUpView.nameTextField.delegate = self
        popUpView.tokenTextField.delegate = self
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        loadRaffles()
        setupVisualEffect()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadRaffles()
    }
    
    private func loadRaffles() {
        APIClient.fetchRaffles { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let raffles):
                    self?.applySnapshot(raffles: raffles)
                }
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
        popUpView.successView.alpha = 0
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
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: homeView.cvContainerView.bounds, collectionViewLayout: CVLayout.createCVLayout(insetVert: 8, insetHor: 18, height: 220))
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = ColorPallete.offWhite.colour
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
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let raffle = dataSource.itemIdentifier(for: indexPath) else { return }
        let vc = RaffleDetailController(raffle)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension HomeController: PopUpDelegate {
    
    func handleDismiss() {
        dismissPopUp()
    }
    
    func handleCreate() {
        
        if !raffleCreatedName.isEmpty && !raffleToken.isEmpty {
            let newRaffle = RafflePost(name: raffleCreatedName, secretToken: raffleToken)
            APIClient.postRaffle(for: newRaffle) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print("Error Posting Raffle \(error.localizedDescription)")
                    case .success(_):
                        self?.loadRaffles()
                        UIView.animate(withDuration: 1.0) {
                            self?.popUpView.successView.alpha = 1
                        } completion: { _ in
                            self?.dismissPopUp()
                            self?.popUpView.nameTextField.text = ""
                            self?.popUpView.tokenTextField.text = ""
                        }
                        
                    }
                }
            }
        } else {
            self.showAlert(alertText: "Please fill out both fields", alertMessage: "")
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
        setNameAndToken(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setNameAndToken(textField: textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
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
