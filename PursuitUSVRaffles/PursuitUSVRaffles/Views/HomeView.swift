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
        button.setBackgroundImage(UIImage(systemName: "crown.fill"), for: .normal)
        button.backgroundColor = .white
        button.contentMode = .center
        button.tintColor = .orange
        //        button.addTarget(self, action: #selector(raffleButtonPressed), for: .touchUpInside)
        //        button.layer.masksToBounds = false
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

protocol PopUpDelegate {
    func handleDismiss()
}

class RafflePopUpView: UIView {
    
    var delegate: PopUpDelegate?
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.rectangle.fill"), for: .normal)
        button.tintColor = .green
//        button.backgroundColor = ColorPallete.lightGreen.colour
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a Raffle"
//        label.font = .preferredFont(forTextStyle: .title1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Involved", for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = ColorPallete.lightGreen.colour
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
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
        self.layer.cornerRadius = 12
        setupDismissalButton()
        setupLabel()
    }
    
    private func setupDismissalButton() {
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dismissButton.widthAnchor.constraint(equalToConstant: 40),
            dismissButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func handleDismiss() {
        delegate?.handleDismiss()
    }
    
    @objc func handleSubmit() {
        
    }
    
}
