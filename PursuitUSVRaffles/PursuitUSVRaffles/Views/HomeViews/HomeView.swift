//
//  HomeView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

protocol SortDelegate {
    func sortByDate()
    func sortByName()
}

class HomeView: UIView {
    
    var delegate: SortDelegate?
    
    public lazy var createRaffleButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 64, height: 64)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        button.backgroundColor = .clear
        button.contentMode = .center
        button.tintColor = ColorPallete.lightBlue.colour
        return button
    }()
    
    public lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "Raffle List"
        label.textColor = ColorPallete.lightBlue.colour
        return label
    }()
    
    public var byDateButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button.setTitle("Date", for: .normal)
        button.backgroundColor = ColorPallete.lightBlue.colour
        button.addTarget(self, action: #selector(sortByDateAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    public var sortByName: UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button.setTitle("Name", for: .normal)
        button.backgroundColor = ColorPallete.lightBlue.colour
        button.addTarget(self, action: #selector(sortByNameAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
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
        
        setupRaffleButton()
        setupHeaderLabel()
        setupSortButtons()
        setupCollectionView()
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
    
    private func setupSortButtons() {
        addSubview(byDateButton)
        addSubview(sortByName)
        byDateButton.translatesAutoresizingMaskIntoConstraints = false
        sortByName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            byDateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            byDateButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            byDateButton.widthAnchor.constraint(equalToConstant: 100),
            byDateButton.heightAnchor.constraint(equalToConstant: 44),
            sortByName.centerYAnchor.constraint(equalTo: byDateButton.centerYAnchor),
            sortByName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sortByName.widthAnchor.constraint(equalToConstant: 100),
            sortByName.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupCollectionView() {
        addSubview(cvContainerView)
        cvContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cvContainerView.topAnchor.constraint(equalTo: byDateButton.bottomAnchor, constant: 12),
            cvContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cvContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cvContainerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    @objc func sortByDateAction() {
        delegate?.sortByDate()
    }
    
    @objc func sortByNameAction() {
        delegate?.sortByName()
    }
    
}

enum SortedBy {
    case byDate
    case byName
}
