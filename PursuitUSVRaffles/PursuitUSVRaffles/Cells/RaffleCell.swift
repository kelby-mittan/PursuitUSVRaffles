//
//  RaffleCell.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class RaffleCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title1)
        label.alpha = 1
        return label
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var raffledAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    public func configureCell(_ raffle: Raffle) {
        titleLabel.text = raffle.name
        
        let calendarAttatchment = NSTextAttachment()
        calendarAttatchment.image = UIImage(systemName: "calendar")
        
        let createdAtStr = NSMutableAttributedString(string: "")
        createdAtStr.append(NSAttributedString(attachment: calendarAttatchment))
        createdAtStr.append(NSAttributedString(string: " \(raffle.createdAt?.date().toString() ?? "") at \(raffle.createdAt?.date().toString(format: "h:mm a") ?? "")"))
        createdAtLabel.attributedText = createdAtStr
        
        let trophyAttatchment = NSTextAttachment()
        trophyAttatchment.image = UIImage(systemName: "crown.fill")
        
        let winnerStr = NSMutableAttributedString(string: "")
        winnerStr.append(NSAttributedString(attachment: trophyAttatchment))
        winnerStr.append(NSAttributedString(string: " Winner ID: \(raffle.winnerID?.description ?? "No winner yet")"))
        winnerLabel.attributedText = winnerStr
        
        let checkAttatchment = NSTextAttachment()
        checkAttatchment.image = UIImage(systemName: "calendar.badge.exclamationmark")
        
        let raffledAtStr = NSMutableAttributedString(string: "")
        raffledAtStr.append(NSAttributedString(attachment: checkAttatchment))
        
        raffle.raffledAt != nil
            ?  raffledAtStr.append(NSAttributedString(string: " \(raffle.raffledAt?.date().toString() ?? "") at \(raffle.raffledAt?.date().toString(format: "h:mm a") ?? "")"))
            :  raffledAtStr.append(NSAttributedString(string: " Not Raffled Yet"))
        raffledAtLabel.attributedText = raffledAtStr
    }
    
    private func setupViews() {
        setupTitleLabel()
        setupCreatedAtLabel()
        setupWinnerLabel()
        setupRaffledAtLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupCreatedAtLabel() {
        contentView.addSubview(createdAtLabel)
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createdAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            createdAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            createdAtLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupWinnerLabel() {
        contentView.addSubview(winnerLabel)
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            winnerLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 8),
            winnerLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            winnerLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupRaffledAtLabel() {
        contentView.addSubview(raffledAtLabel)
        raffledAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            raffledAtLabel.topAnchor.constraint(equalTo: winnerLabel.bottomAnchor, constant: 12),
            raffledAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            raffledAtLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
