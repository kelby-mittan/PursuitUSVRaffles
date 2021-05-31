//
//  SuccessView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/30/21.
//

import UIKit

class SuccessView: UIView {
    
    public lazy var successIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "checkmark.seal.fill")
        return iv
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Raffle Created"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
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
        setupSuccessImage()
        setupLabel()
    }
    
    private func setupSuccessImage() {
        addSubview(successIV)
        successIV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            successIV.centerXAnchor.constraint(equalTo: centerXAnchor),
            successIV.centerYAnchor.constraint(equalTo: centerYAnchor),
            successIV.widthAnchor.constraint(equalToConstant: frame.width/2),
            successIV.heightAnchor.constraint(equalToConstant: frame.width/2)
        ])
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: successIV.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
