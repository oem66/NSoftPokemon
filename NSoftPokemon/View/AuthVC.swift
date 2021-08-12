//
//  ViewController.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/27/21.
//

import UIKit
import SnapKit

class AuthVC: UIViewController, UIConfigurationProtocol {
    
    lazy var titleLabel = UILabel.newLabel(SBString.welcome_title, true, .black, 20)
    lazy var usernameLabel = UILabel.newLabel(SBString.as_username_label, false, .black, 15)
    lazy var usernameTextField = UITextField.newTextField(SBString.as_text_field, false)
    lazy var continueButton = UIButton.newButton(SBString.as_continue_button, .red)
    lazy var signInContainer = UIView()
    
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    internal func setupUI() {
        setNavigation()
        addSubviews()
        setConstraints()
        addButtonAction()
        checkUsernameInKeychain()
        addDoneBtnOnKeyboard()
        removeKeyboard()
    }
    
    internal func setNavigation() {
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.isNavigationBarHidden = true
    }
    
    internal func addSubviews() {
        view.addSubview(signInContainer)
        signInContainer.translatesAutoresizingMaskIntoConstraints = false
        
        signInContainer.addSubview(titleLabel)
        signInContainer.addSubview(usernameLabel)
        signInContainer.addSubview(usernameTextField)
        signInContainer.addSubview(continueButton)
    }
    
    internal func setConstraints() {
        signInContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(80)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameLabel.snp.bottom).offset(60)
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalTo(signInContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
    }
    
    internal func addButtonAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func removeKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func addDoneBtnOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.usernameTextField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func continueButtonTapped() {
        if usernameTextField.text == "" || usernameTextField.text!.count <= 3 {
            UIAlertController.showCustomAlert(for: self, title: SBString.alert_title_username_invalid, message: SBString.alert_message_username_invalid, actionTitle: SBString.alert_action_ok)
        } else {
            saveUsernameToKeychain()
            viewModel.saveUsernameToKeychain(username: usernameTextField.text, key: "UsernameKeychain")
            navigationController?.pushViewController(HomeVC(), animated: true)
        }
    }
}

//MARK: - Working with Keychain
extension AuthVC {
    internal func saveUsernameToKeychain() {
        guard usernameTextField.text != "" && usernameTextField.text!.count > 3 else { return }
        KeychainWrapper.standard.set(usernameTextField.text!, forKey: "UsernameKeychain")
        usernameTextField.resignFirstResponder()
        UserDefaults.standard.set(true, forKey: "UserLoggedIn")
        viewModel.saveUsernameToKeychain(username: usernameTextField.text, key: "UsernameKeychain")
    }
    
    internal func checkUsernameInKeychain() {
        viewModel.checkUsernameInKeychain(for: self, key: "UsernameKeychain") { [weak self] username in
            guard let self = self else { return }
            self.usernameTextField.text = username
            self.navigationController?.pushViewController(HomeVC(), animated: true)
        }
    }
}

extension AuthVC {
    private func showCustomAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
