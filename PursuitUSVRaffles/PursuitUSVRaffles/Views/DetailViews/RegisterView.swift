//
//  RegisterView.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

protocol RegisterDelegate {
    func handleRegistration()
}

class RegisterView: UIView {
    
    var delegate: RegisterDelegate?
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [self.nameLabel,
         self.nameTextField,
            self.emailLabel,
            self.emailTextField,
            self.phoneLabel,
            self.phoneTextField].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter your name"
        textField.backgroundColor = ColorPallete.offWhite.colour
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    public lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter your email"
        textField.backgroundColor = ColorPallete.offWhite.colour
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.numberOfLines = 1
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    public lazy var phoneTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        textField.placeholder = "enter your phone #"
        textField.keyboardType = .numbersAndPunctuation
        textField.backgroundColor = ColorPallete.offWhite.colour
        textField.textColor = ColorPallete.lightBlue.colour
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = ColorPallete.offWhite.colour
        button.setTitleColor(ColorPallete.lightBlue.colour, for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    public lazy var successView: SuccessView = {
        let view = SuccessView()
        view.alpha = 0
        view.backgroundColor = ColorPallete.lightBlue.colour
        view.successIV.image = UIImage(systemName: "checkmark")
        view.successIV.tintColor = ColorPallete.offWhite.colour
        view.titleLabel.text = "You're registered for the raffle"
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
        setupStackView()
        setupRegisterButton()
        setupSuccessView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupRegisterButton() {
        addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: frame.width/2),
            registerButton.heightAnchor.constraint(equalToConstant: 44)
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
    
    @objc func handleRegister() {
        delegate?.handleRegistration()
    }
    
}
