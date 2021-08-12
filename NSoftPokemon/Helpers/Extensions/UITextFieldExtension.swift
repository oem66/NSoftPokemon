//
//  UITextFieldExtension.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/28/21.
//

import Foundation
import UIKit

extension UITextField {
    func placeholderColor(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func newTextField(_ placeholder: String?, _ isSecureEntry: Bool?) -> UITextField {
        let textField = UITextField()
        if let placeholder = placeholder,
           let isSecureEntry = isSecureEntry {
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = placeholder
            textField.placeholderColor(.gray)
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.textColor = .black
            if isSecureEntry {
                textField.isSecureTextEntry = true
            }
        }
        
        return textField
    }
}
