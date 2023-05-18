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
    // Closures
    var onLongPress: (() -> Void)?
    var onEdit: (() -> Void)?
    
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
    
    lazy var lbWorkoutName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    lazy var lbWorkoutDescription: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    lazy var btEdit: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(systemName: "pencil"), for: .normal)
        bt.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        bt.tintColor = UIColor(named: "PrimaryColor")
        return bt
    }()
    
    // MARK: - Cell reuse
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        setupLongPressGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            onLongPress?()
        }
    }
    
    @objc private func handleEdit() {
        onEdit?()
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(cardView)
        cardView.addSubview(lbWorkoutName)
        cardView.addSubview(lbWorkoutDescription)
        cardView.addSubview(btEdit)
    }
    
    func setupConstraints() {
        cardView.edgesToSuperview(insets: UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16))
        cardView.height(200, relation: .equalOrGreater)
        
        lbWorkoutName.topToSuperview(offset: 24)
        lbWorkoutName.leadingToSuperview(offset: 16)
        lbWorkoutName.trailingToSuperview(offset: 16)
        
        lbWorkoutDescription.centerYToSuperview()
        lbWorkoutDescription.leadingToSuperview(offset: 16)
        lbWorkoutDescription.trailingToSuperview(offset: 16)
        
        btEdit.topToSuperview(offset: 24)
        btEdit.trailingToSuperview(offset: 24)
        btEdit.width(36)
        btEdit.height(36)
    }
    
    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(workout: Workout) {
        lbWorkoutName.text = workout.workoutName
        lbWorkoutDescription.text = workout.workoutDescription
    }
}
