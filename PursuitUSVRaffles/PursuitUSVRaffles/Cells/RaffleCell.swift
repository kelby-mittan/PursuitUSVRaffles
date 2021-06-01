//
//  RaffleCell.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

class RaffleCell: UICollectionViewCell {
    
    static let reuseIdentifier = "raffleCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 28)
        label.alpha = 1
        return label
    }()
    
    private lazy var createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    private lazy var raffledAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = ColorPallete.offWhite.colour
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .headline)
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public func configureCell(_ raffle: Raffle) {
        titleLabel.text = raffle.name
        
        let calendarAttatchment = NSTextAttachment()
        calendarAttatchment.image = UIImage(systemName: "calendar")
        
        let createdAtStr = NSMutableAttributedString(string: "")
        createdAtStr.append(NSAttributedString(attachment: calendarAttatchment))
        
        createdAtStr.append(NSAttributedString(string: "  Created on \(raffle.createdAt?.dateToString().date ?? "") at \(raffle.createdAt?.dateToString().time ?? "")"))
        
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
            ?  raffledAtStr.append(NSAttributedString(string: " Raffle won on \(raffle.raffledAt?.dateToString().date ?? "") at \(raffle.raffledAt?.dateToString().time ?? "")"))
            :  raffledAtStr.append(NSAttributedString(string: " Not Raffled Yet"))
        raffledAtLabel.attributedText = raffledAtStr
    }
    
    private func setupViews() {
        setupTitleLabel()
        setupCreatedAtLabel()
        setupWinnerLabel()
        setupRaffledAtLabel()
        self.backgroundColor = ColorPallete.lightBlue.colour
        self.layer.cornerRadius = 12
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
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
