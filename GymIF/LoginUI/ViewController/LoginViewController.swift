//
//  ViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 13/05/23.
//

import UIKit
import TinyConstraints
import GoogleSignIn

protocol LoginViewControllerDisplay: AnyObject {
    func loginFailure(with message: String)
    func showLoading()
    func hideLoading()
}

public class LoginViewController: UIViewController {

    private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var ivLogo = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var btLogin: GIDSignInButton = {
        let bt = GIDSignInButton()
        bt.style = .wide
        return bt
    }()

    private lazy var btGhostLogin: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .clear
        return bt
    }()

    private lazy var btLogout: UIButton = {
        let bt = UIButton()
        bt.titleLabel?.tintColor = .white
        bt.backgroundColor = UIColor(red: 0.825, green: 0.035, blue: 0.362, alpha: 1.0)
        bt.layer.cornerRadius = 25
        bt.setTitle("Logout", for: .normal)
        return bt
    }()
    
    // MARK: - Actions
    @objc func loginButtonTapped() {
        viewModel.login()
    }
    
    @objc func logoutButtonTapped() {
        viewModel.logout()
    }
    
    func setupButtonActions() {
        btGhostLogin.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        btLogout.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewController = self
        setupHierarchy()
        setupLayout()
        setupButtonActions()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(ivLogo)
        view.addSubview(btLogin)
        view.addSubview(btGhostLogin)
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
        
        // login button constraints
        btGhostLogin.height(60)
        btGhostLogin.topToBottom(of: ivLogo, offset: 100)
        btGhostLogin.leadingToSuperview(offset: 36)
        btGhostLogin.trailingToSuperview(offset: 36)
        
        // logout button constraints
        btLogout.height(50)
        btLogout.topToBottom(of: btLogin, offset: 20)
        btLogout.leadingToSuperview(offset: 36)
        btLogout.trailingToSuperview(offset: 36)
    }
}

// TODO: - Implement this cases if needed.
extension LoginViewController: LoginViewControllerDisplay {
    func loginFailure(with message: String) {}
    func showLoading() {}
    func hideLoading() {}
}
