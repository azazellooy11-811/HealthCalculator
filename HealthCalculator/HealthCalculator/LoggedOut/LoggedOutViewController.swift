//
//  LoggedOutViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 02.06.2023.
//

import SnapKit
import UIKit

class LoggedOutViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "loggedOutImage")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillEqually
        view.alignment = .center
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .buttonColor
        button.setTitle("Log in".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .buttonColor
        button.setTitle("Register".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(goToRegisterScreen),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    // MARK: - Private Methods
    @objc
    private func goToRegisterScreen() {
        navigationController?.pushViewController(RegisterScreenViewController(),
                                                 animated: true)
    }
    
    
    private func setupUI() {
        view.addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(logInButton)
        buttonsStackView.addArrangedSubview(registerButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(180)
        }

        registerButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
    }
}
