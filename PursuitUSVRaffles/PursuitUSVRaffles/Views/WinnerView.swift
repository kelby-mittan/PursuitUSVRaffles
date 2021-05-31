//
//  WinnerView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

class WinnerView: UIView {
            
    private lazy var winnerIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle.fill")
        return iv
    }()
    
    private lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
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
        setupWinnerIV()
        setupWinnerLabel()
    }
    
    private func setupWinnerIV() {
        addSubview(winnerIV)
        winnerIV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            winnerIV.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            winnerIV.centerXAnchor.constraint(equalTo: centerXAnchor),
            winnerIV.widthAnchor.constraint(equalToConstant: frame.width/1.5),
            winnerIV.heightAnchor.constraint(equalToConstant: frame.width/1.5)
        ])
    }
    
    private func setupWinnerLabel() {
        addSubview(winnerLabel)
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            winnerLabel.topAnchor.constraint(equalTo: winnerIV.bottomAnchor, constant: 12),
            winnerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            winnerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
        ])
    }
    
    public func configureView(_ participant: Participant, _ raffle: Raffle) {
        winnerLabel.text = "\(participant.firstname ?? "") \(participant.lastname ?? "") won this raffle on \(raffle.raffledAt?.dateToString().date ?? "") at \(raffle.raffledAt?.dateToString().time ?? "")"
    }
    
}
