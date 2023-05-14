//
//  ViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 13/05/23.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {
    
    // MARK: - Properties
    let ivLogo = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let tfUserName = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 25
        tf.setLeadingPadding(16)
        tf.placeholder = "Please enter with your google email."
        return tf
    }()
    
    let tfUserPassword = {
        let tf = UITextField()
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 25
        tf.setLeadingPadding(16)
        tf.placeholder = "Please enter your account password"
        return tf
    }()
    
    let btLogin = {
        let bt = UIButton()
        bt.layer.cornerRadius = 25
        bt.titleLabel?.tintColor = .white
        bt.backgroundColor = UIColor(red: 0.825, green: 0.035, blue: 0.362, alpha: 1.0)
        bt.titleLabel?.textColor = .white
        bt.setTitle("Login", for: .normal)
        return bt
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(ivLogo)
        view.addSubview(tfUserName)
        view.addSubview(tfUserPassword)
        view.addSubview(btLogin)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.backgroundColor = .white
        tfUserName.delegate = self
        tfUserPassword.delegate = self
        // TODO: - Should be created a class to handle with sizes
        
        // logo constraints
        ivLogo.centerXToSuperview()
        ivLogo.centerYToSuperview(offset: -60)
        ivLogo.width(200)
        ivLogo.height(200)
        
        // username Textfield constraints
        tfUserName.height(50)
        tfUserName.topToBottom(of: ivLogo, offset: 80)
        tfUserName.leadingToSuperview(offset: 36)
        tfUserName.trailingToSuperview(offset: 36)
        
        // password Textfield constraints
        tfUserPassword.height(50)
        tfUserPassword.topToBottom(of: tfUserName, offset: 20)
        tfUserPassword.leadingToSuperview(offset: 36)
        tfUserPassword.trailingToSuperview(offset: 36)
        
        // login button constraints
        btLogin.height(50)
        btLogin.topToBottom(of: tfUserPassword, offset: 20)
        btLogin.leadingToSuperview(offset: 36)
        btLogin.trailingToSuperview(offset: 36)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
