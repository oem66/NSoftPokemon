//
//  AuthViewModel.swift
//  NSoftPokemon
//
//  Created by OMERS on 4. 8. 2021..
//

import Foundation
import UIKit

class AuthViewModel {
    internal func conntinueButtonTapped(username: String?, for key: String?, for viewController: UIViewController) {
        guard let username = username else { return }
        if let key = key {
            saveUsernameToKeychain(username: username, key: key)
        }
    }
    
    internal func saveUsernameToKeychain(username: String?, key: String?) {
        if let username = username,
           let key = key {
            KeychainWrapper.standard.set(username, forKey: key)
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
        }
    }
    
    internal func checkUsernameInKeychain(for viewController: UIViewController, key: String?, completion: @escaping (String)->()) {
        guard let key = key else { return }
        if let username = KeychainWrapper.standard.string(forKey: key) {
            if UserDefaults.standard.bool(forKey: "UserLoggedIn") {
                completion(username)
            }
        }
    }
}
