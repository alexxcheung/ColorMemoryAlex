//
//  CollectionViewCell.swift
//  ColorMemory
//
//  Created by Alex Cheung on 25/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    static var identifier: String = "CardCell"
    
    weak var textLabel: UILabel!
    var isMatched: Bool! {
        didSet {
            if isMatched == true {
                self.contentView.backgroundColor = .white
            } else if isMatched == false {
                self.contentView.backgroundColor = .black
                UIView.transition(with: self.contentView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        }
    }
    var isShown: Bool! {
        didSet {
            if isShown {
                setupColor()
                UIView.transition(with: self.contentView, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            } else {
                self.contentView.backgroundColor = .black
            }
        }
    }
    
    var cardId: Int!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        self.contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
        ])
        self.textLabel = textLabel
        self.backgroundColor = .black
    }
    
    func setupColor() {
        // accroding to the number
        switch cardId {
        case 1:
            self.contentView.backgroundColor = .red
        case 2:
            self.contentView.backgroundColor = .yellow
        case 3:
            self.contentView.backgroundColor = .blue
        case 4:
            self.contentView.backgroundColor = .brown
        case 5:
            self.contentView.backgroundColor = .cyan
        case 6:
            self.contentView.backgroundColor = .green
        case 7:
            self.contentView.backgroundColor = .darkGray
        case 8:
            self.contentView.backgroundColor = .magenta
        default:
            self.contentView.backgroundColor = .black
        }
    
    }

}
