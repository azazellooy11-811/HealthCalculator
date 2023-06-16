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
        
        return view
    }()
    
    private lazy var firstCheckboxImageView: UIImageView = {
       let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var secondCheckboxImageView: UIImageView = {
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
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupGradient()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(genderContainerView)
        genderContainerView.addSubview(genderLabel)
        genderContainerView.addSubview(firstCheckboxImageView)
        genderContainerView.addSubview(maleLabel)
        genderContainerView.addSubview(secondCheckboxImageView)
        genderContainerView.addSubview(femaleLabel)
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        genderContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(10)
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

