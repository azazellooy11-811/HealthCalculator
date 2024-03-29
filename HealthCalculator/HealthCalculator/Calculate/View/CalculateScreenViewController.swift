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
    private lazy var boldLabels: [UILabel] = []
    private lazy var containerView = UIView()
    private lazy var labelsOfRadioButtons: [UILabel] = []
    private lazy var radioButtons: [UIButton] = []
    private lazy var textFields: [UITextField] = []
    private lazy var button = UIButton()
    
    // MARK: - Properties
    var textFieldsList: [UITextField] = []
    var radioButtonsList: [UIButton] = []
    var buttons: [UIButton] = []
    var viewModel: CalculateViewModelProtocol
    var selectedGender: Gender?
    var selectedGoal: Goal?
    var isButtonBlocked = true
    var login: String
    
    // MARK: - Initialize
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
    
    // MARK: - Methods
    func initLabelsOfRadioButtons(names: [String]) {
        names.forEach { name in
            let label = UILabel()
            
            label.text = name.localized
            labelsOfRadioButtons.append(label)
        }
    }
    
    func initRadioButtons(count: Int) {
        for i in 0 ..< count {
            let radioButton = UIButton.init(type: .custom)
            
            radioButton.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
            radioButton.setImage(UIImage.checkmark, for: .selected)
            radioButton.addTarget(self, action: #selector(toggleRadioButtons), for: .touchUpInside)
            radioButton.tag = i
            
            radioButtons.append(radioButton)
            radioButtonsList.append(radioButton)
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
            textFieldsList.append(textField)
        }
    }
    
    func initButton(title: String) {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle(title.localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(clickButton),
                         for: .touchUpInside)
        
        self.button = button
    }
    
    @objc
    func toggleRadioButtons(sender: UIButton) {
        if sender.isSelected {
            selectedGender = nil
            selectedGoal = nil
        }
        sender.isSelected = !sender.isSelected
        let unSelectedButtons = radioButtons.filter { $0 != sender }
        unSelectedButtons.forEach { button in
            button.isSelected = false
        }
    }
    
    @objc
    func clickButton() {
        view.endEditing(true)
        guard !isButtonBlocked else { return initAlert(title: "Error",
                                                       message: "Please fill the form using integer only. We don't accept other characters.",
                                                       preferredStyle: .alert) }
        navigationController?.pushViewController(MobilityAndGoalScreenViewController(login: login, viewModel: viewModel), animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubviews(labelsOfRadioButtons)
        containerView.addSubviews(radioButtons)
        view.addSubviews(boldLabels)
        view.addSubviews(textFields)
        view.addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
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
                        make.top.equalTo(containerView.snp.bottom)
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
                    make.bottom.equalTo(containerView.snp.top)
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
                bottom = containerView.snp.top
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
        
        button.snp.makeConstraints { make in
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
