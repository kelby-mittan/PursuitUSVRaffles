//
//  RafflePopUpView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/30/21.
//

import UIKit

protocol PopUpDelegate {
    func handleDismiss()
    func handleCreate()
}

class RafflePopUpView: UIView {
    
    var delegate: PopUpDelegate?
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.rectangle.fill"), for: .normal)
        button.tintColor = ColorPallete.peach.colour
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a Raffle"
        label.textColor = ColorPallete.lightBlue.colour
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    public lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter raffle name"
        textField.layer.borderColor = ColorPallete.lightBlue.colour.cgColor
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    public lazy var tokenTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter a secret token"
        textField.layer.borderColor = ColorPallete.lightBlue.colour.cgColor
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = ColorPallete.lightBlue.colour
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    public lazy var successView: SuccessView = {
        let view = SuccessView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.alpha = 0
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
        self.layer.cornerRadius = 12
        self.backgroundColor = .magenta
        setupDismissalButton()
        setupLabel()
        setupNameTextField()
        setupTokenTextField()
        setupCreateButton()
        setupSuccessView()
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
    
    private func setupNameTextField() {
        addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupTokenTextField() {
        addSubview(tokenTextField)
        tokenTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tokenTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 18),
            tokenTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            tokenTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            tokenTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func setupCreateButton() {
        addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: tokenTextField.bottomAnchor, constant: 24),
            createButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: frame.width/2),
            createButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSuccessView() {
        addSubview(successView)
        successView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successView.topAnchor.constraint(equalTo: topAnchor),
            successView.leadingAnchor.constraint(equalTo: leadingAnchor),
            successView.trailingAnchor.constraint(equalTo: trailingAnchor),
            successView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func handleDismiss() {
        delegate?.handleDismiss()
    }
    
    @objc func handleSubmit() {
        delegate?.handleCreate()
    }
    
}
