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
    
    private lazy var rectangle: UIView = {
        let view = UIView()
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        print("rectangle")
        return view
    }()
    
    private lazy var cameraImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "camera")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(addCameraImage))
        
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var galleryImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "gallery")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(addImage))
        
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "profile")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        print("profileImage")
        
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
        button.setTitle("Выход".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
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
    var showError: ((String) -> Void)?
    var login: String
    private var isOpenedEditMenuProfileImage: Bool = false
    private var imageName: String?
    private var imageUrl = UserDefaults.standard.string(forKey: "imageUr")
    
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
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            EditMenuProfileImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("configure will use")
        configure()
        print("configure used")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rectangle.frame = CGRect(x: Int(self.profileImage.frame.minX),
                                 y: Int(self.profileImage.frame.minY),
                                 width: 100,
                                 height: 100)
    }

    // MARK: - Private Methods
    private func loadImageFromSavedPath() {
        if let savedImagePath = UserDefaults.standard.string(forKey: "savedImagePath") {
            let imageURL = URL(fileURLWithPath: savedImagePath)
            if let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) {
                profileImage.image = image
            }
        }
    }
    func handleResult(_ result: Result<[String], Error>) {
        switch result {
        case .success(let articles):
            print(articles)
        case .failure(let error):
            DispatchQueue.main.async {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    @objc
    func logout() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    @objc
    private func addCameraImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            print("photo is not avaible")
        }
    }
    
    private func configure() {
        let profileInfo = ProfileInfoPersistent.fetchProfileInfo(login: login)
        firstName.text = profileInfo.firstName
        lastName.text = profileInfo.lastName
        caloriesLabel.text = "Calories: \(profileInfo.calories)"
        proteinsLabel.text = "Proteins: \(profileInfo.proteins)"
        fatsLabel.text = "Fats: \(profileInfo.fats)"
        carbohydrateLabel.text = "Carbohydrate: \(profileInfo.carbohydrate)"
        loadImageFromSavedPath()
    }
    
    private func setupUI() {
        view.addSubview(rectangle)
        rectangle.addSubviews([cameraImage, galleryImage])
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
        
        cameraImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(30)
            make.width.height.equalTo(50)
        }
        
        galleryImage.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(30)
            make.width.height.equalTo(50)
        }
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.safeAreaLayoutGuide.layoutFrame
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func EditMenuProfileImage() {
        isOpenedEditMenuProfileImage = !isOpenedEditMenuProfileImage
        let width = isOpenedEditMenuProfileImage ? 300: 100
        let height = isOpenedEditMenuProfileImage ? 110: 100
        
        if width == 100 {
            cameraImage.isHidden = true
            galleryImage.isHidden = true
        } else {
            cameraImage.isHidden = false
            galleryImage.isHidden = false
        }
      
        UIView.animate(withDuration: 1.0) {
            self.rectangle.frame = CGRect(x: Int(self.profileImage.frame.minX), y: Int(self.profileImage.frame.minY), width: width, height: height)
            self.rectangle.center = self.profileImage.center
        }
        
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ProfileScreenViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            if let imageData = selectedImage.jpegData(compressionQuality: 1.0) {
                guard let fm = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let fileName = UUID().uuidString + ".jpeg"
                let fileUrl = fm.appendingPathComponent(fileName)
                do {
                    try imageData.write(to: fileUrl)
                    UserDefaults.standard.set(fileUrl.path, forKey: "savedImagePath")
                } catch let error {
                    print(error)
                }
            }
            profileImage.image = selectedImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
