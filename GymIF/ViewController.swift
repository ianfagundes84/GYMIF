//
//  ViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 13/05/23.
//

import UIKit
import TinyConstraints
import GoogleSignIn

class ViewController: UIViewController {
    
    // MARK: - Properties
    let ivLogo = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let btLogin: GIDSignInButton = {
        let bt = GIDSignInButton()
        bt.style = .wide
        return bt
    }()
    
    let btLogout = {
        let bt = UIButton()
        bt.layer.cornerRadius = 25
        bt.titleLabel?.tintColor = .white
        bt.backgroundColor = UIColor(red: 0.825, green: 0.035, blue: 0.362, alpha: 1.0)
        bt.titleLabel?.textColor = .white
        bt.setTitle("Logout", for: .normal)
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
        view.addSubview(btLogin)
        view.addSubview(btLogout)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.backgroundColor = .white
        
        // logo constraints
        ivLogo.centerXToSuperview()
        ivLogo.centerYToSuperview(offset: -40)
        ivLogo.width(200)
        ivLogo.height(200)
        
        // login button constraints
        btLogin.height(60)
        btLogin.topToBottom(of: ivLogo, offset: 100)
        btLogin.leadingToSuperview(offset: 36)
        btLogin.trailingToSuperview(offset: 36)
        
        // logout button constraints
        btLogout.height(50)
        btLogout.topToBottom(of: btLogin, offset: 20)
        btLogout.leadingToSuperview(offset: 36)
        btLogout.trailingToSuperview(offset: 36)
    }
}


