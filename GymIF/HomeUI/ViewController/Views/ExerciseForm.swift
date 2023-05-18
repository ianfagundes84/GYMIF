//
//  ExerciseForm.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import Foundation
import UIKit

class ExerciseForm: UIView {

    var onTouchUpInside: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }


    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    @objc private func buttonTapped() {
        onTouchUpInside?()
    }
}


