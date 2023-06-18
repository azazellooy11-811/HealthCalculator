//
//  CalculateScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 15.06.2023.
//

import UIKit
import SnapKit

class CalculateScreenViewController: UIViewController {
    enum State {
        case select, unselect
        
        var image: UIImage {
            switch self {
            case .select:
                return UIImage.checkmark
            case .unselect:
                return UIImage(systemName: "circlebadge") ?? UIImage.add
            }
        }
    }
    
    // MARK: - GUI Variables
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Gender"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var maleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "male"
        
        return label
    }()
    
    private lazy var femaleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "female"
        
        return label
    }()
    
    private lazy var genderContainerView: UIView = {
        let view = UIView()
        
        view.layer.borderColor = UIColor(ciColor: .red).cgColor
        
        return view
    }()
    
    private lazy var femaleCheckboxImageView: UIImageView = {
       let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var maleCheckboxImageView: UIImageView = {
       let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Age"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "age".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Height"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "height".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Weight"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "weight".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle("next".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        
        
        return button
    }()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //setupGradient()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(genderContainerView)
        genderContainerView.addSubview(genderLabel)
        genderContainerView.addSubview(femaleCheckboxImageView)
        genderContainerView.addSubview(maleLabel)
        genderContainerView.addSubview(maleCheckboxImageView)
        genderContainerView.addSubview(femaleLabel)
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        view.addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        genderContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.equalToSuperview().inset(25)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        femaleCheckboxImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(genderLabel.snp.bottom)
        }
        
        femaleLabel.snp.makeConstraints { make in
            make.leading.equalTo(femaleCheckboxImageView.snp.trailing).offset(5)
            make.top.equalTo(genderLabel.snp.bottom)
        }
        
        maleCheckboxImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(femaleCheckboxImageView.snp.bottom)
        }
        
        maleLabel.snp.makeConstraints { make in
            make.leading.equalTo(maleCheckboxImageView.snp.trailing).offset(5)
            make.top.equalTo(femaleLabel.snp.bottom)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(genderContainerView.snp.top).inset(85)
        }
        
        ageTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(ageLabel.snp.bottom).offset(5)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(ageTextField.snp.bottom).offset(25)
        }
        
        heightTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(heightLabel.snp.bottom).offset(5)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(heightTextField.snp.bottom).offset(25)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(weightLabel.snp.bottom).offset(5)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
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

