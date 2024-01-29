//
//  LogInScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 07.06.2023.
//

import SnapKit
import UIKit

class LogInScreenViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var logInTitle: UILabel = {
        let label = UILabel()
        
        label.text = "Log in".localized
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
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle("Log in".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(checkUser), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var viewModel: ProfileViewModelProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
    }
    
    // MARK: - Private Methods
    @objc
    private func checkUser() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        
        if KeychainManager.logInUser(login: login, password: password) {
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
            UserDefaults.standard.set(login, forKey: "login")
           
            let profileInfo = ProfileInfoPersistent.fetchProfileInfo(login: login)
            
            navigationController?.pushViewController(TabBarController(login: login), animated: true)
        } else {
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Логин или пароль неправильные! Попробуй снова".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized, style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(logInTitle)
        containerView.addSubview(loginTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(logInButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        logInTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logInTitle.snp.bottom).offset(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(loginTextField.snp.bottom).offset(15)
        }
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
        }
    }
}
