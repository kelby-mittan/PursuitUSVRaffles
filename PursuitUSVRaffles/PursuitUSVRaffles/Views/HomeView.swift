//
//  HomeView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class HomeView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .orange
        collection.register(RaffleCell.self, forCellWithReuseIdentifier: "raffleCell")
        return collection
    }()
    
//    private lazy var createRaffleButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Create Raffle", for: .normal)
//        button.layer.cornerRadius = 18
//        button.backgroundColor = ColorPallete.lightGreen.colour
//        button.addTarget(self, action: #selector(raffleButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = ColorPallete.offWhite.colour
        setupCollectionView()
//        setupRaffleButton()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height*1/8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
//    private func setupRaffleButton() {
//        collectionView.addSubview(createRaffleButton)
//        createRaffleButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            createRaffleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
//            createRaffleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            createRaffleButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
//            createRaffleButton.heightAnchor.constraint(equalToConstant: 60)
//        ])
//    }
    
    @objc func raffleButtonPressed() {
        // TODO: create a pop up for new raffle
    }
    
}
