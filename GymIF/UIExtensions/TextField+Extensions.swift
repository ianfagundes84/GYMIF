//
//  TextField+Extensions.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit
extension UITextField {
    var isValid: Bool {
        if let text = self.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }

    func changeBorderColorIfEmpty() {
        self.layer.borderColor = self.isValid ? UIColor.gray.cgColor : UIColor.red.cgColor
    }

    func resetBorderColorIfNotEmpty() {
        if self.isValid {
            self.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func setLeadingPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
