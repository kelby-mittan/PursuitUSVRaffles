//
//  PickWinnerView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

protocol WinnerDelegate {
    func pickWinner()
}

class PickWinnerView: UIView {
    
    var delegate: WinnerDelegate?
    
    private lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Secret Token"
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public lazy var tokenTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter the secret token"
        textField.backgroundColor = ColorPallete.offWhite.colour
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    private lazy var pickWinnerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick Winner", for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = ColorPallete.offWhite.colour
        button.setTitleColor(ColorPallete.lightBlue.colour, for: .normal)
        button.addTarget(self, action: #selector(handlePickingWinner), for: .touchUpInside)
        return button
    }()
    
    public lazy var successView: SuccessView = {
        let view = SuccessView()
        view.alpha = 0
        view.backgroundColor = .white
        view.successIV.image = UIImage(systemName: "sparkles")
        view.successIV.tintColor = ColorPallete.offWhite.colour
        view.titleLabel.text = ""
        view.titleLabel.textColor = ColorPallete.offWhite.colour
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
        setupTokenLabel()
        setupTokenTextField()
        setupRegisterButton()
        setupSuccessView()
    }
    
    private func setupTokenLabel() {
        addSubview(tokenLabel)
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            tokenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tokenLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    private func setupTokenTextField() {
        addSubview(tokenTextField)
        tokenTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenTextField.topAnchor.constraint(equalTo: tokenLabel.bottomAnchor, constant: 12),
            tokenTextField.leadingAnchor.constraint(equalTo: tokenLabel.leadingAnchor),
            tokenTextField.trailingAnchor.constraint(equalTo: tokenLabel.trailingAnchor),
            tokenTextField.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupRegisterButton() {
        addSubview(pickWinnerButton)
        pickWinnerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickWinnerButton.topAnchor.constraint(equalTo: tokenTextField.bottomAnchor, constant: 20),
            pickWinnerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickWinnerButton.widthAnchor.constraint(equalToConstant: frame.width/2),
            pickWinnerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSuccessView() {
        addSubview(successView)
        successView.translatesAutoresizingMaskIntoConstraints = false
        successView.backgroundColor = ColorPallete.lightBlue.colour
        NSLayoutConstraint.activate([
            successView.topAnchor.constraint(equalTo: self.topAnchor),
            successView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            successView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            successView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func handlePickingWinner() {
        delegate?.pickWinner()
    }
    
}
