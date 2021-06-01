//
//  HomeView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class HomeView: UIView {
    
    public lazy var createRaffleButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 64, height: 64)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        button.backgroundColor = .clear
        button.contentMode = .center
        button.tintColor = .orange
        return button
    }()
    
    public lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Raffle List"
        return label
    }()
    
    public lazy var cvContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        setupRaffleButton()
        setupHeaderLabel()
    }
    
    private func setupRaffleButton() {
        addSubview(createRaffleButton)
        createRaffleButton.translatesAutoresizingMaskIntoConstraints = false
        let widthHeight = UIScreen.main.bounds.height*1/14
        NSLayoutConstraint.activate([
            createRaffleButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -18),
            createRaffleButton.widthAnchor.constraint(equalToConstant: widthHeight),
            createRaffleButton.heightAnchor.constraint(equalToConstant: widthHeight),
            createRaffleButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height*1/24)
        ])
    }
    
    private func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            headerLabel.bottomAnchor.constraint(equalTo: createRaffleButton.bottomAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: createRaffleButton.leadingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        addSubview(cvContainerView)
        cvContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cvContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height*1/12),
            cvContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cvContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cvContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
