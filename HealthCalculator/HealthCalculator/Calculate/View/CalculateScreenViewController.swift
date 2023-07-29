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
        
        view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var femaleCheckboxImageView: UIButton = {
        let checkbox = UIButton.init(type: .custom)
        //        checkbox.setImage(UIImage.init(named: "iconCheckboxOutlined"), for: .normal)
        //        checkbox.setImage(UIImage.init(named: "iconCheckboxFilled"), for: .selected)
        checkbox.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        checkbox.setImage(UIImage.checkmark, for: .selected)
        //checkbox.setImage(UIImage.checkmark, for: .selected)
        //checkbox.setImage(UIImage(systemName: "circlebadge"), for: .normal)
        
        checkbox.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        //        view.image = State.unselect.image
        //        view.contentMode = .center
        
        return checkbox
    }()
    
    private lazy var maleCheckboxImageView: UIButton = {
        let checkbox = UIButton.init(type: .custom)
        
        checkbox.setImage(UIImage.init(systemName: "circlebadge"), for: .normal)
        checkbox.setImage(UIImage.checkmark, for: .selected)
        
        checkbox.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
        //        view.image = State.unselect.image
        //        view.contentMode = .center
        
        return checkbox
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
        button.setTitle("Log in".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(clickButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var isAnthropometricDataScreen = true //антропометрические данные
    var isMobilityAndGoalScreen = false
    
    var isFirstClicked = false
    
    var viewModel: CalculateViewModelProtocol
    var isSelected: Bool = false
    var selectedGender: Gender =  .female
    var login: String
    
    
    
    //    private(set) var isCheckedFemale: Bool = false {
    //            didSet{
    //                femaleCheckboxImageView.image = self.isCheckedFemale ? State.select.image : State.unselect.image
    //            }
    //        }
    
    //    private(set) var isCheckedMale: Bool = false {
    //            didSet{
    //                femaleCheckboxImageView.image = self.isCheckedFemale ? State.select.image : State.unselect.image
    //            }
    //        }
    
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
        
        ageTextField.delegate = self
        weightTextField.delegate = self
        heightTextField.delegate = self
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
    func toggleCheckboxSelection() {
        femaleCheckboxImageView.isSelected = !femaleCheckboxImageView.isSelected
        maleCheckboxImageView.isSelected = femaleCheckboxImageView.isSelected ? maleCheckboxImageView.isSelected : !maleCheckboxImageView.isSelected
        
        if femaleCheckboxImageView.isSelected {
            maleCheckboxImageView.isSelected = false
            selectedGender = .female
        } else if maleCheckboxImageView.isSelected {
            selectedGender = .male
            femaleCheckboxImageView.isSelected = false
        }
        
    }
    
    //        print("g")
    //        if femaleCheckboxImageView.isSelected {
    //            selectedGender = .female
    //            femaleCheckboxImageView.isSelected = !femaleCheckboxImageView.isSelected
    //        } else if maleCheckboxImageView.isSelected {
    //            femaleCheckboxImageView.isSelected = !femaleCheckboxImageView.isSelected
    //            selectedGender = .male
    //        }
    //    }
    
    private func setupMobilityAndGoalScreen() {
        print("2")
        ageLabel.text = "Среднее количество шагов в месяц"
        ageTextField.text = "Количество шагов"
        heightLabel.text = "Кардио тренировки в минутах за неделю"
        heightTextField.text = "Кардио в минутах"
        weightLabel.text = "Силовые тренировки в минутах за неделю"
        weightTextField.text = "Силовые тренировки в минутах"
        
    }
    
    @objc
    private func clickButton() {
        print("1")
        isFirstClicked = !isFirstClicked
        if isFirstClicked {
            setupMobilityAndGoalScreen()
        } else {
            returnResult()
        }
        
//        if isAnthropometricDataScreen {
//            
//            
//        }
//        isMobilityAndGoalScreen = true
//        isAnthropometricDataScreen = false
//        if isMobilityAndGoalScreen {
//            setupMobilityAndGoalScreen()
//            isMobilityAndGoalScreen = false
//        } else {
//            returnResult()
//        }
    }
    
   
    func returnResult() {
        print("g")
        
        let result = viewModel.returnCalories()
        let alert = UIAlertController(title: "Error".localized,
                                      message: "калории \(result) ".localized,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    private func setupUI() {
        view.addSubview(genderContainerView)
        genderContainerView.addSubviews([genderLabel,
                                         femaleCheckboxImageView,
                                         maleLabel,
                                         maleCheckboxImageView,
                                         femaleLabel])
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
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            make.top.equalTo(genderContainerView.snp.bottom)
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
        guard let age = ageTextField.text,
              let height = heightTextField.text,
              let weight = weightTextField.text,
              let ageInt = Int(age),
              let heightInt = Int(height),
              let weightInt = Int(weight) else { return }
        
        let gender = femaleCheckboxImageView.isSelected ? Gender.female : Gender.male
        
        viewModel.get(gender: gender, age: ageInt , height: heightInt , weight: weightInt)
        viewModel.get(steps: 5000, cardio: 10, workout: 10)
        viewModel.get(goal: .weightLoss)
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
