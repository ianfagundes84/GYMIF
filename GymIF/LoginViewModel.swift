//
//  LoginViewModel.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import GoogleSignIn

protocol LoginViewModelContract: AnyObject {
    func login()
    func logout()
}

final class LoginViewModel: LoginViewModelContract {
    // MARK: - Properties
    weak var viewController: UIViewController?
    
    // MARK: - Methods
    func login() {
        guard let viewController = viewController, let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject], let clientID = dict["CLIENT_ID"] as? String else { return }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            guard error == nil else { return }
            print("LOGGED IN")
        }
    }
    
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
        print("LOGGED OUT")
    }
}
