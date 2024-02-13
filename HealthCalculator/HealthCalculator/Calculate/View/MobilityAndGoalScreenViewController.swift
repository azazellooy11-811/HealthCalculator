//
//  MobilityAndGoalScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 30.08.2023.
//

import UIKit
import SnapKit

class MobilityAndGoalScreenViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var goalLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Goal".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var weightLossLabel: UILabel = {
        let label = UILabel()
        
        label.text = "weightLoss".localized
        
        return label
    }()
    
    private lazy var weightRetentionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "weightRetention".localized
        
        return label
    }()
    
    private lazy var weightGainLabel: UILabel = {
        let label = UILabel()
        
        label.text = "weightGain".localized
        
        return label
    }()
    
    private lazy var goalContainerView = UIView()
    
    private lazy var weightLossImageView: UIButton = {
        let radioButton = UIButton.init(type: .custom)
        radioButton.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        radioButton.setImage(UIImage.checkmark, for: .selected)
        radioButton.tag = 0
        radioButton.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        
        
        return radioButton
    }()
    
    private lazy var weightRetentionImageView: UIButton = {
        let radioButton = UIButton.init(type: .custom)
        
        radioButton.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        radioButton.setImage(UIImage.checkmark, for: .selected)
        radioButton.tag = 1
        radioButton.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        
        return radioButton
    }()
    
    private lazy var weightGainImageView: UIButton = {
        let radioButton = UIButton.init(type: .custom)
        radioButton.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        radioButton.setImage(UIImage.checkmark, for: .selected)
        radioButton.tag = 2
        radioButton.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        
        return radioButton
    }()
    
    private lazy var stepsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Average number of steps per month".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var stepsTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "number of steps".localized
        textField.borderStyle = .roundedRect
        
        
        return textField
    }()
    
    private lazy var cardioLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Cardio training in minutes in a week".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var cardioTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "cardio in minutes".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var trainingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Strength training in minutes".localized
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var trainingTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "strength training in minutes".localized
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var showResultButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .green
        button.setTitle("Show result".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(returnResult),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    
    var viewModel: CalculateViewModelProtocol
    var selectedGoal: Goal?
    var isButtonBlocked = true
    var login: String
    
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
        
        stepsTextField.delegate = self
        cardioTextField.delegate = self
        trainingTextField.delegate = self
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
    @objc
    func toggleCheckboxSelection(radioButton: UIButton) {
        radioButton.isSelected = !radioButton.isSelected
        switch radioButton.tag {
        case 0: selectedGoal = .weightLoss
        case 1: selectedGoal = .weightRetention
        case 2: selectedGoal = .weightGain
        default: print("no")
        }
    }
    
    private func setAlert(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title.localized,
                                      message: message.localized,
                                      preferredStyle: preferredStyle)
        let action = UIAlertAction(title: "OK".localized, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    @objc
    func returnResult() {
        view.endEditing(true)
        guard !isButtonBlocked else { return setAlert(title: "Ошибка!",
                                                      message: "Заполните все поля",
                                                      preferredStyle: .alert) }
        let result = viewModel.returnCalories()
        setAlert(title: "КБЖУ".localized,
                 message: """
                                      Калории: \(result.calories) \n
                                      Белки: \(result.proteins) \n
                                      Жиры: \(result.fats) \n
                                      Углеводы: \(result.carbohydrate)
                                      """.localized,
                 preferredStyle: .alert)
    }
    
    private func setupUI() {
        view.addSubview(goalContainerView)
        goalContainerView.addSubviews([goalLabel,
                                       weightLossLabel,
                                       weightRetentionLabel,
                                       weightGainLabel,
                                       weightLossImageView,
                                       weightRetentionImageView,
                                       weightGainImageView])
        view.addSubviews([stepsLabel,
                          stepsTextField,
                          cardioLabel,
                          cardioTextField,
                          trainingLabel,
                          trainingTextField,
                          showResultButton])
        setupConstraints()
    }
    
    private func setupConstraints() {
        goalContainerView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        goalLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        weightLossImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(goalLabel.snp.bottom)
        }
        
        weightLossLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightLossImageView.snp.trailing).offset(10)
            make.top.equalTo(goalLabel.snp.bottom)
        }
        
        weightRetentionImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(weightLossImageView.snp.bottom)
        }
        
        weightRetentionLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightRetentionImageView.snp.trailing).offset(10)
            make.top.equalTo(weightLossLabel.snp.bottom).offset(2)
        }
        
        weightGainImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(weightRetentionImageView.snp.bottom)
        }
        
        weightGainLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightGainImageView.snp.trailing).offset(10)
            make.top.equalTo(weightRetentionLabel.snp.bottom).offset(2)
        }
        
        stepsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(goalContainerView.snp.bottom)
        }
        
        stepsTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(stepsLabel.snp.bottom).offset(5)
        }
        
        cardioLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(stepsTextField.snp.bottom).offset(25)
        }
        
        cardioTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(cardioLabel.snp.bottom).offset(5)
        }
        
        trainingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(cardioTextField.snp.bottom).offset(25)
        }
        
        trainingTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(trainingLabel.snp.bottom).offset(5)
        }
        
        showResultButton.snp.makeConstraints { make in
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

extension MobilityAndGoalScreenViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let steps = stepsTextField.text,
           let cardio = cardioTextField.text,
           let workout = trainingTextField.text,
           let stepsInt = Int(steps),
           let cardioInt = Int(cardio),
           let workoutInt = Int(workout), let goal = selectedGoal {
            isButtonBlocked = false
            
            viewModel.get(steps: stepsInt, cardio: cardioInt, workout: workoutInt)
            viewModel.get(goal: goal)
        } else {
            return isButtonBlocked = true
        }
    }
}

// MARK: - Keyboard events
private extension MobilityAndGoalScreenViewController {
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
