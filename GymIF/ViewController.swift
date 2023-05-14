//
//  ViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 13/05/23.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {
    
    let label = {
        let lb = UILabel()
        lb.text = "Hello, World!"
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(label)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        label.centerInSuperview()
    }
}


