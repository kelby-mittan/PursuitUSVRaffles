//
//  RaffleDetailView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

protocol DetailViewDelegate {
    func handleDismiss()
    func handleSegController(_ sender: UISegmentedControl)
}

class RaffleDetailView: UIView {

    var delegate: DetailViewDelegate?
    
    private var items = [UIImage(systemName: "person.3.fill"),
                         UIImage(systemName: "rectangle.and.pencil.and.ellipsis"),
                         UIImage(systemName: "hands.sparkles.fill")]
        
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone 12 Pro Raffle"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.backward.square.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    public lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: items as [Any])
        segControl.backgroundColor = .systemGray
        segControl.selectedSegmentIndex = 0
        segControl.selectedSegmentTintColor(.blue)
        segControl.addTarget(self, action: #selector(handleSegmentedControlChange(_:)), for: .valueChanged)
        return segControl
    }()
    
    public lazy var contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    public lazy var registerView: RegisterView = {
        let view = RegisterView()
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
        setupBackButton()
        setupNameLabel()
        setupSegControl()
        setupContentContainer()
//        contentContainer.addSubview(registerView)
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    private func setupSegControl() {
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/1.5),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupContentContainer() {
        addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func handleSegmentedControlChange(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            print("participants")
//        case 1:
//            print("register")
//        default:
//            print("winner")
//        }
        delegate?.handleSegController(sender)
    }
    
    @objc func handleDismiss() {
        delegate?.handleDismiss()
    }
}

