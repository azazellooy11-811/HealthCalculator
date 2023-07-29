//
//  ProfileScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 08.06.2023.
//

import SnapKit
import UIKit

class ProfileScreenViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "profile")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var firstName: UILabel = {
        let label = UILabel()
        
        label.text = "Azaliia"
        label.font = .boldSystemFont(ofSize: 18)
        label.contentMode = .center
        
        return label
    }()
    
    private lazy var lastName: UILabel = {
        let label = UILabel()
        
        label.text = "Halilova"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle("Удалить акк".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(deleteAcc), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Calories: 0"
        
        return label
    }()
    
    private lazy var proteinsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Proteins: 0"
        
        return label
    }()
    
    private lazy var fatsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Fats: 0"
        
        return label
    }()
    
    private lazy var carbohydrateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Carbohydrate: 0"
        
        return label
    }()
    
    // MARK: - Properties
    var login: String
    
    init(login: String) {
        self.login = login
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupGradient()
        setupUI()
        
        navigationController?.navigationBar.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("configure will use")
        configure()
        print("configure used")
    }
    // MARK: - Private Methods
    @objc
    func deleteAcc() {
        ProfileInfoPersistent.delete(from: login)
        KeychainManager.deleteUser(login: login)
        print("юзер удален")
    }
    
    private func configure() {
        let profileInfo = ProfileInfoPersistent.fetchProfileInfo(login: login)
        firstName.text = profileInfo.firstName
        lastName.text = profileInfo.lastName
        caloriesLabel.text = "Calories: \(profileInfo.calories)"
        proteinsLabel.text = "Proteins: \(profileInfo.proteins)"
        fatsLabel.text = "Fats: \(profileInfo.fats)"
        carbohydrateLabel.text = "Carbohydrate: \(profileInfo.carbohydrate)"
    }
    
    private func setupUI() {
        view.addSubview(profileImage)
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(logOutButton)
        view.addSubview(caloriesLabel)
        view.addSubview(proteinsLabel)
        view.addSubview(fatsLabel)
        view.addSubview(carbohydrateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        firstName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(5)
        }
        
        lastName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstName.snp.bottom).offset(5)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(lastName.snp.bottom).offset(20)
        }
        
        caloriesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logOutButton.snp.bottom).offset(20)
        }
        
        proteinsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(caloriesLabel.snp.bottom).offset(20)
        }
        
        fatsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(proteinsLabel.snp.bottom).offset(20)
        }
        
        carbohydrateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fatsLabel.snp.bottom).offset(20)
        }
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.safeAreaLayoutGuide.layoutFrame
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

