//
//  RegisterScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 03.06.2023.
//

import SnapKit
import UIKit

class RegisterScreenViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var registerTitle: UILabel = {
        let label = UILabel()
        
        label.text = "Register".localized
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Login".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Password".localized
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "First Name".localized
        textField.borderStyle = .roundedRect
        
        
        return textField
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Last Name".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .buttonColor
        button.setTitle("next".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self,
                         action: #selector(registerUser),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(registerTitle)
        containerView.addSubview(loginTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(firstNameTextField)
        containerView.addSubview(lastNameTextField)
        containerView.addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        registerTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(registerTitle.snp.bottom).offset(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(loginTextField.snp.bottom).offset(15)
        }
        
        firstNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
        }
        
        lastNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(firstNameTextField.snp.bottom).offset(15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lastNameTextField.snp.bottom).offset(50)
        }
    }
    
    @objc
    private func registerUser() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text else { return }
        
        if KeychainManager.registerUser(login: login,
                                     password: password,
                                     firstName: firstName,
                                        lastName: lastName) {
            print("успешно зарегистрирован")
            // TODO: - придумай тут что-нибудь, может алерт какой-нибудь
            navigationController?.pushViewController(LoggedOutViewController(), animated: true)
        } else {
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Пользователь не зарегистрирован! Попробуй снова".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

extension RegisterScreenViewController: UITextFieldDelegate {
    
}
