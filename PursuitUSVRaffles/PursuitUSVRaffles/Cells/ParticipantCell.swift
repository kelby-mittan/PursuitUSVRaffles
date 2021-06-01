//
//  ParticipantCell.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/30/21.
//

import UIKit

class ParticipantCell: UICollectionViewCell {
    
    static let reuseIdentifier = "participantCell"
    
    private lazy var participantIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle.fill")
        return iv
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        [self.nameLabel,
            self.idLabel,
            self.emailLabel,
            self.phoneLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func configureCell(_ participant: Participant) {
        
        nameLabel.text = "\(participant.firstname ?? "") \(participant.lastname ?? "")"
        
        let hashTagAttatchment = NSTextAttachment()
        hashTagAttatchment.image = UIImage(systemName: "number.square.fill")
        let idStr = NSMutableAttributedString(string: "")
        idStr.append(NSAttributedString(attachment: hashTagAttatchment))
        idStr.append(NSAttributedString(string: " id: \(participant.id?.description ?? "")"))
        idLabel.attributedText = idStr
        
        let emailAttatchment = NSTextAttachment()
        emailAttatchment.image = UIImage(systemName: "envelope")
        let emailStr = NSMutableAttributedString(string: "")
        emailStr.append(NSAttributedString(attachment: emailAttatchment))
        emailStr.append(NSAttributedString(string: " email: \(participant.email ?? "")"))
        emailLabel.attributedText = emailStr
        
        let phoneAttatchment = NSTextAttachment()
        phoneAttatchment.image = UIImage(systemName: "phone")
        let phoneStr = NSMutableAttributedString(string: "")
        phoneStr.append(NSAttributedString(attachment: phoneAttatchment))
        phoneStr.append(NSAttributedString(string: " email: \(participant.phone ?? "")"))
        phoneLabel.attributedText = phoneStr
    }
    
    private func commonInit() {
        self.backgroundColor = .cyan
        self.layer.cornerRadius = 12
        setupParticipantIV()
        setupStackView()
    }
    
    private func setupParticipantIV() {
        contentView.addSubview(participantIV)
        participantIV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            participantIV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            participantIV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            participantIV.widthAnchor.constraint(equalToConstant: 100),
            participantIV.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: participantIV.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
}
