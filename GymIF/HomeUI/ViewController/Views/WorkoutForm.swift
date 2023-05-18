//
//  WorkoutForm.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import UIKit
import TinyConstraints

public class WorkoutForm: UIView {
    
    private var viewModel: WorkoutViewModel?
    
    private lazy var cardView: UIView = {
        let uv = UIView()
        uv.layer.cornerRadius = 16
        uv.backgroundColor = .white
        return uv
    }()
    
    private lazy var tfWorkoutName: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 25
        tf.setLeadingPadding(16)
        tf.placeholder = "Please enter a workout name."
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var tfWorkoutDescription: UITextField = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 25
        tf.setLeadingPadding(16)
        tf.placeholder = "Please enter workout`s description."
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var btCreateWorkout: AddButton = {
        let bt = AddButton()
        bt.onTouchUpInside = workoutCreationTapped
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBuildHierarchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupBuildHierarchy() {
        addSubview(cardView)
        cardView.addSubview(tfWorkoutName)
        cardView.addSubview(tfWorkoutDescription)
        cardView.addSubview(btCreateWorkout)
    }
    
    func setupLayout() {
        cardView.height(350)
        cardView.centerYToSuperview()
        cardView.leadingToSuperview(offset: 16)
        cardView.trailingToSuperview(offset: 16)
        
        tfWorkoutName.topToSuperview(offset: 64)
        tfWorkoutName.leadingToSuperview(offset: 16)
        tfWorkoutName.trailingToSuperview(offset: 16)
        tfWorkoutName.height(50)
        
        tfWorkoutDescription.topToBottom(of: tfWorkoutName, offset: 24)
        tfWorkoutDescription.leadingToSuperview(offset: 16)
        tfWorkoutDescription.trailingToSuperview(offset: 16)
        tfWorkoutDescription.height(50)
        
        btCreateWorkout.trailingToSuperview(offset: 24)
        btCreateWorkout.bottomToSuperview(offset: -24)
        btCreateWorkout.width(50)
        btCreateWorkout.height(50)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    static func create(with viewModel: WorkoutViewModel) -> WorkoutForm {
        let view = WorkoutForm(frame: .zero)
        view.viewModel = viewModel
        return view
    }
}

extension WorkoutForm: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.resetBorderColorIfNotEmpty()
    }
    
    func formValidation(textFields: [UITextField]) -> Bool {
        return textFields.allSatisfy { $0.isValid }
    }

    func workoutCreationTapped() {
        let textFieldsToValidate = [tfWorkoutName, tfWorkoutDescription]
        if formValidation(textFields: textFieldsToValidate) {
            _ = viewModel?.createWorkout(name: tfWorkoutName.text!, description: tfWorkoutDescription.text!, date: Date())
            viewModel?.delegate?.dismissWorkoutForm()
        } else {
            textFieldsToValidate.forEach { $0.changeBorderColorIfEmpty() }
        }
    }
}


