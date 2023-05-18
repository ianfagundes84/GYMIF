//
//  WorkOutTableViewCell.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit
import TinyConstraints

class WorkOutTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier : String = "identifier"
    
    lazy var cardView: UIView = {
        let card = UIView()
        card.layer.cornerRadius = 8
        card.layer.masksToBounds = false
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.2
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 4
        card.backgroundColor = UIColor.white
        return card
    }()
    
    // MARK: - Cell reuse
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func buildViewHierarchy() {
        contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        cardView.edgesToSuperview(insets: UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16))
        cardView.height(200, relation: .equalOrGreater)
    }
    
    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(title: String) {
    }
}
