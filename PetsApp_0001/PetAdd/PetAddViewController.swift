//
//  PetAddViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit
import Firebase
import Photos

final class PetAddViewController: UIViewController,
                                  PetAddDisplayLogic {
    
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    
    // MARK: - Fields
    private let imageView: UIImageView = UIImageView()
    private let selectImage: UIButton = UIButton()
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let imagePicker = UIImagePickerController()
    private let cameraPicker = UIImagePickerController()
    private let nameLabel: UILabel = UILabel()
    private let nameField: UITextField = UITextField()
    private let typeLabel: UILabel = UILabel()
    private let typeField: UITextField = UITextField()
    private let breedLabel: UILabel = UILabel()
    private let breedField: UITextField = UITextField()
    private let colorLabel: UILabel = UILabel()
    private let colorField: UITextField = UITextField()
    private let birthLabel: UILabel = UILabel()
    private let datePicker   = UIDatePicker()
    private let addButton: UIButton = UIButton()
    private let agreeAlert: UIAlertController = UIAlertController(title: "Подтвердите действие", message: "Добавьте питомца или заполните/отредактируйте поля", preferredStyle: UIAlertController.Style.alert)
    private let alert: UIAlertController = UIAlertController(title: "Ошибка", message: "Заполните обязательное поле (Имя)", preferredStyle: UIAlertController.Style.alert)
    private let router: PetAddRoutingLogic
    private let interactor: PetAddBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: PetAddRoutingLogic,
        interactor: PetAddBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let tapKeyBoard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapKeyBoard)
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        let cameraAction = UIAlertAction(title: "Камера", style: .default){ _ in
            self.requestCameraAccess()
        }
        let photoAction = UIAlertAction(title: "Фото", style: .default){ _ in
            self.requestPhotoLibraryAccess()
        }
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)

        let agreeAddAction = UIAlertAction(title: "Добавить питомца", style: .default){ _ in
            self.agreeButtonTapped()
        }
        agreeAlert.addAction(agreeAddAction)
        agreeAlert.addAction(cancelAction)
        
        interactor.loadStart(Model.Start.Request())
        
        nameField.delegate = self
        typeField.delegate = self
        breedField.delegate = self
        colorField.delegate = self
        let doneButton = UIBarButtonItem(title: "Добавить питомца", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItem = doneButton
        let agreeAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(agreeAction)
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureImageView()
        configureSelectImageButton()
        configureImagePicker()
        configureCameraPicker()
        configureNameLabel()
        configureNameField()
        configureTypeLabel()
        configureTypeField()
        configureBreedLabel()
        configureBreedField()
        configureColorLabel()
        configureColorField()
        configureBirthLabel()
        configureDatePicker()
        
        
        
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.setWidth(193)
        imageView.setHeight(193)
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        imageView.pinCenterX(to: view)
        imageView.image = UIImage(named: "no_photo")
        
    }
    
    private func configureSelectImageButton() {
        view.addSubview(selectImage)
        
        selectImage.setTitle("select_image".localized, for: .normal)
        selectImage .backgroundColor = .clear
        selectImage.setTitleColor(.systemBlue, for: .normal)
        selectImage.titleLabel?.pinCenterX(to: view)
        selectImage.pinTop(to: imageView.bottomAnchor, 5)
        selectImage.pinCenterX(to: view)
        selectImage.addTarget(self, action: #selector(imageUser), for: .touchUpInside)
        
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "\("name_field".localized):"
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.pinTop(to: selectImage.bottomAnchor, 10)
        nameLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        nameLabel.textColor = .label
    }
    
    private func configureNameField() {
        view.addSubview(nameField)
        
        nameField.setWidth(350)
        nameField.setHeight(35)
        nameField.placeholder = "Буся (обязательное поле)"
        nameField.font = UIFont.boldSystemFont(ofSize: 20)
        nameField.pinLeft(to: nameLabel.trailingAnchor, 5)
        nameField.pinCenterY(to: nameLabel.centerYAnchor)
        nameField.autocapitalizationType = .sentences
        nameField.returnKeyType = .done
        nameField.textColor = .label
    }
    
    private func configureTypeLabel() {
        view.addSubview(typeLabel)
        
        typeLabel.text = "\("Вид питомца"):"
        typeLabel.font = UIFont.systemFont(ofSize: 20)
        typeLabel.pinTop(to: nameLabel.bottomAnchor, 10)
        typeLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        typeLabel.textColor = .label
    }
    
    private func configureTypeField() {
        view.addSubview(typeField)
        
        typeField.setWidth(350)
        typeField.setHeight(35)
        typeField.placeholder = "Кошка"
        typeField.font = UIFont.boldSystemFont(ofSize: 20)
        typeField.pinLeft(to: typeLabel.trailingAnchor, 5)
        typeField.pinCenterY(to: typeLabel.centerYAnchor)
        typeField.autocapitalizationType = .sentences
        typeField.returnKeyType = .done
        typeField.textColor = .label
    }
    
    private func configureBreedLabel() {
        view.addSubview(breedLabel)
        
        breedLabel.text = "\("Порода"):"
        breedLabel.font = UIFont.systemFont(ofSize: 20)
        breedLabel.pinTop(to: typeLabel.bottomAnchor, 10)
        breedLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        breedLabel.textColor = .label
    }
    
    private func configureBreedField() {
        view.addSubview(breedField)
        
        breedField.setWidth(350)
        breedField.setHeight(35)
        breedField.placeholder = "Британская"
        breedField.font = UIFont.boldSystemFont(ofSize: 20)
        breedField.pinLeft(to: breedLabel.trailingAnchor, 5)
        breedField.pinCenterY(to: breedLabel.centerYAnchor)
        breedField.autocapitalizationType = .sentences
        breedField.returnKeyType = .done
        breedField.textColor = .label
    }
    
    private func configureColorLabel() {
        view.addSubview(colorLabel)
        
        colorLabel.text = "\("Окрас"):"
        colorLabel.font = UIFont.systemFont(ofSize: 20)
        colorLabel.pinTop(to: breedLabel.bottomAnchor, 10)
        colorLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        colorLabel.textColor = .label
    }
    
    private func configureColorField() {
        view.addSubview(colorField)
        
        colorField.setWidth(350)
        colorField.setHeight(35)
        colorField.placeholder = "белое золото"
        colorField.font = UIFont.boldSystemFont(ofSize: 20)
        colorField.pinLeft(to: colorLabel.trailingAnchor, 5)
        colorField.pinCenterY(to: colorLabel.centerYAnchor)
        colorField.returnKeyType = .done
        colorField.textColor = .label
    }
    
    private func configureBirthLabel() {
        view.addSubview(birthLabel)
        
        birthLabel.text = "\("Дата рождения"):"
        birthLabel.font = UIFont.systemFont(ofSize: 20)
        birthLabel.pinTop(to: colorLabel.bottomAnchor, 10)
        birthLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        birthLabel.textColor = .label
    }
    
    private func configureDatePicker() {
        view.addSubview(datePicker)
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.pinLeft(to: birthLabel.trailingAnchor, 5)
        datePicker.pinCenterY(to: birthLabel.centerYAnchor)
        
    }
    
    private func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
    }
    
    private func configureCameraPicker() {
        cameraPicker.delegate = self
        cameraPicker.allowsEditing = true
        cameraPicker.sourceType = .camera
    }
    
    // MARK: - Actions
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func imageUser() {
        self.present(alertController, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            self.alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
    }
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func openPhotoGallery(){
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openCamera(){
        DispatchQueue.main.async {
            self.present(self.cameraPicker, animated: true, completion: nil)
        }
    }
    
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.openPhotoGallery()
                }
            case .denied, .restricted:
                print("Доступ к фотографиям запрещен или ограничен")
            case .notDetermined:
                print("Пользователь еще не принял решение")
            @unknown default:
                break
            }
        }
    }
    
    private func requestCameraAccess() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            openCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera()
                    }
                } else {
                    print("Доступ к камере запрещен")
                }
            }
        case .denied, .restricted:
            print("Доступ к камере запрещен или ограничен")
        @unknown default:
            break
        }
    }
    
    @objc func doneButtonTapped() {
        if (nameField.text!.isEmpty) {
            self.present(self.alert, animated: true)
        }else{
            self.present(agreeAlert, animated: true)
        }
        
    }
    
    @objc func agreeButtonTapped(){
        
        interactor.loadPets(PetAddModel.Pets.Request(name: nameField.text!, type: typeField.text!, breed: breedField.text!, dateBirth: datePicker.date, date: Date(), photo: imageView.image, color: colorField.text!))
        
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayPets(_ viewModel: Model.Pets.ViewModel) {
        router.routeToPets()
    }
}
// MARK: - UITextFieldDelegate

extension PetAddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            typeField.becomeFirstResponder()
        } else if textField == typeField {
            breedField.becomeFirstResponder()
        } else if textField == breedField {
            colorField.becomeFirstResponder()
        } else if textField == colorField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension PetAddViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print("1")
        if let selectedImage = info[.editedImage] as? UIImage {
            imageView.image = selectedImage
        } else if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
