//
//  CalculateScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 15.06.2023.
//

import UIKit
import SnapKit

class CalculateScreenViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Gender".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    private lazy var boldLabels: [UILabel] = []
    private lazy var genderContainerView = UIView()
    private lazy var labelsOfRadioButtons: [UILabel] = []
    private lazy var radioButtons: [UIButton] = []
    private lazy var textFields: [UITextField] = []
    
    private lazy var femaleCheckboxImageView: UIButton = {
        let checkbox = UIButton.init(type: .custom)
        checkbox.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        checkbox.setImage(UIImage.checkmark, for: .selected)
        checkbox.isSelected = true
        
        checkbox.addTarget(self, action: #selector(toggleGenderCheckbox), for: .touchUpInside)
        
        checkbox.tag = 0
        
        return checkbox
    }()
    
    private lazy var maleCheckboxImageView: UIButton = {
        let checkbox = UIButton.init(type: .custom)
        
        checkbox.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        checkbox.setImage(UIImage.checkmark, for: .selected)
        
        checkbox.addTarget(self, action: #selector(toggleGenderCheckbox), for: .touchUpInside)
        
        checkbox.tag = 1
        
        return checkbox
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Age".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "age".localized
        textField.borderStyle = .roundedRect
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Height".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "height".localized
        textField.borderStyle = .roundedRect
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Weight".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "weight".localized
        textField.borderStyle = .roundedRect
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle("Next".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(clickButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var viewModel: CalculateViewModelProtocol
    var selectedGender: Gender = .female
    var selectedGoal: Goal = .weightGain
    var isButtonBlocked = true
    var login: String
    
    var buttons: [UIButton] = []
    
    
    init(login: String, viewModel: CalculateViewModelProtocol) {
        self.login = login
        self.viewModel = viewModel
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
        hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private Methods
    func initLabelsOfRadioButtons(names: [String]) {
        names.forEach { name in
            let label = UILabel()
            
            label.text = name
            labelsOfRadioButtons.append(label)
        }
    }
    
    func initRadioButtons(count: Int) {
        for _ in 0 ..< count {
            let radioButton = UIButton.init(type: .custom)
            
            radioButton.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
            radioButton.setImage(UIImage.checkmark, for: .selected)
            
            radioButtons.append(radioButton)
        }
    }
    
    func initBoldLabels(texts: [String]) {
        texts.forEach { text in
            let label = UILabel()
            
            label.text = text.localized
            label.font = .boldSystemFont(ofSize: 18)
            
            boldLabels.append(label)
        }
    }
    
    func initTextFields(placeholders: [String]) {
        placeholders.forEach { placeholder in
            let textField = UITextField()
            
            textField.placeholder = placeholder.localized
            textField.borderStyle = .roundedRect
            
            textField.delegate = self
            
            textFields.append(textField)
        }
    }
    
    @objc
    func toggleGenderCheckbox() {
        selectedGender = selectedGender == .male ? .female : .male
        maleCheckboxImageView.isSelected = selectedGender == .male
        femaleCheckboxImageView.isSelected = selectedGender == .female
    }
    
    @objc
    private func clickButton() {
        view.endEditing(true)
        guard !isButtonBlocked else { return initAlert(title: "Ошибка!",
                                                      message: "Заполните все поля",
                                                      preferredStyle: .alert) }
        viewModel.get(gender: selectedGender)
        navigationController?.pushViewController(MobilityAndGoalScreenViewController(login: login, viewModel: viewModel), animated: true)
    }
    
    func returnResult() {
        let result = viewModel.returnCalories()
        initAlert(title: "КБЖУ", message: "Калории: \(result.calories)", preferredStyle: .alert)
    }
    
    
    private func setupUI() {
            view.addSubview(genderContainerView)
        genderContainerView.addSubviews(labelsOfRadioButtons)
            genderContainerView.addSubviews(radioButtons)
        view.addSubviews(boldLabels)
        view.addSubviews(textFields)
//            view.addSubview(ageLabel)
//            view.addSubview(ageTextField)
//            view.addSubview(heightLabel)
//            view.addSubview(heightTextField)
//            view.addSubview(weightLabel)
//            view.addSubview(weightTextField)
            view.addSubview(nextButton)
            
            setupConstraints()
        }
    
    private func setupConstraints() {
        genderContainerView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        var prevRadioButton: UIButton? = nil
        var prevLabel: UILabel? = nil
        var prevBoldLabel: UILabel? = nil
        var prevTextField: UITextField? = nil
        
        for i in 0 ..< boldLabels.count {
            
            let label = boldLabels[i]
            
            
            if let prevBoldLabel {
                if i == 1 {
                    label.snp.makeConstraints { make in
                        make.leading.equalToSuperview().inset(25)
                        make.top.equalTo(genderContainerView.snp.bottom)
                    }
                    
                    textFields[i-1].snp.makeConstraints { make in
                        make.leading.equalToSuperview().inset(25)
                        make.top.equalTo(label.snp.bottom).offset(5)
                    }
                    
                } else {
                    if let prevTextField {
                        label.snp.makeConstraints { make in
                            make.leading.equalToSuperview().inset(25)
                            make.top.equalTo(prevTextField.snp.bottom).offset(25)
                        }
                        
                        textFields[i-1].snp.makeConstraints { make in
                            make.leading.equalToSuperview().inset(25)
                            make.top.equalTo(label.snp.bottom).offset(5)
                        }
                    }
                }
                
                prevTextField = textFields[i-1]
                
            } else {
                label.snp.makeConstraints { make in
                    make.leading.equalToSuperview().inset(25)
                    make.bottom.equalTo(genderContainerView.snp.top)
                }
            }
            
            prevBoldLabel = label
        }
        
        for i in 0 ..< labelsOfRadioButtons.count {
            let label = labelsOfRadioButtons[i]
            let checkbox = radioButtons[i]
            
            let bottom: ConstraintItem
            
            if let prevRadioButton {
                bottom = prevRadioButton.snp.bottom
            }
            else {
                bottom = genderContainerView.snp.top
            }
            
            checkbox.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.top.equalTo(bottom)
            }
            
            if let prevLabel {
                label.snp.makeConstraints { make in
                    make.leading.equalTo(checkbox.snp.trailing).offset(10)
                    make.top.equalTo(prevLabel.snp.bottom).offset(2)
                }
            }
            else {
                label.snp.makeConstraints { make in
                    make.leading.equalTo(checkbox.snp.trailing).offset(10)
                    make.top.equalTo(bottom)
                }
            }
            prevLabel = label
            prevRadioButton = checkbox
        }
        
//        ageLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(genderContainerView.snp.bottom)
//        }
        
//        ageTextField.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(ageLabel.snp.bottom).offset(5)
//        }
//
//        heightLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(ageTextField.snp.bottom).offset(25)
//        }
//
//        heightTextField.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(heightLabel.snp.bottom).offset(5)
//        }
//
//        weightLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(heightTextField.snp.bottom).offset(25)
//        }
//
//        weightTextField.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(25)
//            make.top.equalTo(weightLabel.snp.bottom).offset(5)
//        }
//
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(view.frame.width / 2)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
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

extension CalculateScreenViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let age = ageTextField.text,
           let height = heightTextField.text,
           let weight = weightTextField.text,
           let ageInt = Int(age),
           let heightInt = Int(height),
           let weightInt = Int(weight) {
            isButtonBlocked = false
            
            viewModel.get(age: ageInt , height: heightInt , weight: weightInt)
            
        } else {
            return isButtonBlocked = true
        }
    }
}

// MARK: - Keyboard events

private extension CalculateScreenViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame =
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect  else { return }
        view.largeContentImageInsets.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        view.largeContentImageInsets.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
