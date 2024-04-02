//
//  PetEditViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit
import Firebase
import Photos

final class PetEditViewController: UIViewController,
                                   PetEditDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let imageView: UIImageView = UIImageView()
    private let selectImage: UIButton = UIButton()
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let alertDelete = UIAlertController(title: "delete_pet_page".localized, message: "delete_pet_confirm".localized, preferredStyle: .alert)
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
    private let lastVactLabel: UILabel = UILabel()
    private let yearVactLabel: UILabel = UILabel()
    private let lastBathLabel: UILabel = UILabel()
    private let datePickerBirth = UIDatePicker()
    private let datePickerLastVact = UIDatePicker()
    private let datePickerYearVact = UIDatePicker()
    private let datePickerLastBath = UIDatePicker()
    
    private let addButton: UIButton = UIButton()
    private var fullScreenImageView: UIImageView?
    private let editAlert: UIAlertController = UIAlertController(title: "changes_saved".localized, message: "to_pets_page".localized, preferredStyle: UIAlertController.Style.alert)
    private let alert: UIAlertController = UIAlertController(title: "error_alert".localized, message: "Fill_required_field_name".localized, preferredStyle: UIAlertController.Style.alert)
    private let router: PetEditRoutingLogic
    private let interactor: PetEditBusinessLogic
    
    private let pet: PetModel
    
    // MARK: - LifeCycle
    init(
        router: PetEditRoutingLogic,
        interactor: PetEditBusinessLogic,
        pet: PetModel
    ) {
        self.router = router
        self.interactor = interactor
        self.pet = pet
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
        let cancelAction = UIAlertAction(title: "cancelB".localized, style: .destructive)
        let deleteAction = UIAlertAction(title: "delete_pet".localized, style: .destructive) { _ in
            self.agreeDeleteTapped()
            
        }
        let cancelDeleteAction = UIAlertAction(title: "cancelB".localized, style: .default)
        let cameraAction = UIAlertAction(title: "camera".localized, style: .default){ _ in
            self.requestCameraAccess()
        }
        let photoAction = UIAlertAction(title: "photo_library".localized, style: .default){ _ in
            self.requestPhotoLibraryAccess()
        }
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        alertDelete.addAction(deleteAction)
        alertDelete.addAction(cancelDeleteAction)
        
        let doneButton = UIBarButtonItem(title: "save_changes".localized, style: .done, target: self, action: #selector(doneButtonTapped))
        let deleteButton = UIBarButtonItem(title: "delete_pet".localized, style: .plain, target: self, action:
                                            #selector(deleteWasTapped))
        deleteButton.tintColor = .red
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItems = [doneButton, deleteButton]
        
        
        deleteButton.isEnabled = true
        
        interactor.loadStart(Model.Start.Request())
        nameField.delegate = self
        typeField.delegate = self
        breedField.delegate = self
        colorField.delegate = self
        
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapImageGesture)
        imageView.isUserInteractionEnabled = true
        
        let okAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(okAction)
        
        let agreeAction = UIAlertAction(title: "ОК", style: .default) { _ in
            self.agreeButtonTapped()
        }
        editAlert.addAction(agreeAction)
        
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
        configureDatePickerBirth()
        configureLastVactLabel()
        configureDatePickerLastVact()
        configureYearVactLabel()
        configureDatePickerYearVact()
        configureLastBathLabel()
        configureDatePickerLastBath()
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
        imageView.image = pet.image
        
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
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.pinTop(to: selectImage.bottomAnchor, 12)
        nameLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        nameLabel.textColor = .label
    }
    
    private func configureNameField() {
        view.addSubview(nameField)
        
        nameField.setWidth(350)
        nameField.setHeight(35)
        nameField.text = pet.name
        nameField.placeholder = "Bysya".localized
        nameField.font = UIFont.boldSystemFont(ofSize: 17)
        nameField.pinLeft(to: nameLabel.trailingAnchor, 5)
        nameField.pinCenterY(to: nameLabel.centerYAnchor)
        nameField.autocapitalizationType = .sentences
        nameField.returnKeyType = .done
        nameField.textColor = .label
    }
    
    private func configureTypeLabel() {
        view.addSubview(typeLabel)
        
        typeLabel.text = "\("type_pet".localized):"
        typeLabel.font = UIFont.systemFont(ofSize: 17)
        typeLabel.pinTop(to: nameLabel.bottomAnchor, 12)
        typeLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        typeLabel.textColor = .label
    }
    
    private func configureTypeField() {
        view.addSubview(typeField)
        
        typeField.setWidth(350)
        typeField.setHeight(35)
        typeField.text = pet.type
        typeField.placeholder = "cat".localized
        typeField.font = UIFont.boldSystemFont(ofSize: 17)
        typeField.pinLeft(to: typeLabel.trailingAnchor, 5)
        typeField.pinCenterY(to: typeLabel.centerYAnchor)
        typeField.autocapitalizationType = .sentences
        typeField.returnKeyType = .done
        typeField.textColor = .label
    }
    
    private func configureBreedLabel() {
        view.addSubview(breedLabel)
        
        breedLabel.text = "\("breed".localized):"
        breedLabel.font = UIFont.systemFont(ofSize: 17)
        breedLabel.pinTop(to: typeLabel.bottomAnchor, 12)
        breedLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        breedLabel.textColor = .label
    }
    
    private func configureBreedField() {
        view.addSubview(breedField)
        
        breedField.setWidth(350)
        breedField.setHeight(35)
        breedField.text = pet.breed
        breedField.placeholder = "british_shorthair".localized
        breedField.font = UIFont.boldSystemFont(ofSize: 17)
        breedField.pinLeft(to: breedLabel.trailingAnchor, 5)
        breedField.pinCenterY(to: breedLabel.centerYAnchor)
        breedField.autocapitalizationType = .sentences
        breedField.returnKeyType = .done
        breedField.textColor = .label
    }
    
    private func configureColorLabel() {
        view.addSubview(colorLabel)
        
        colorLabel.text = "\("colorPetB".localized):"
        colorLabel.font = UIFont.systemFont(ofSize: 17)
        colorLabel.pinTop(to: breedLabel.bottomAnchor, 12)
        colorLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        colorLabel.textColor = .label
    }
    
    private func configureColorField() {
        view.addSubview(colorField)
        
        colorField.setWidth(350)
        colorField.setHeight(35)
        colorField.text = pet.color
        colorField.placeholder = "white_gold".localized
        colorField.font = UIFont.boldSystemFont(ofSize: 17)
        colorField.pinLeft(to: colorLabel.trailingAnchor, 5)
        colorField.pinCenterY(to: colorLabel.centerYAnchor)
        colorField.returnKeyType = .done
        colorField.textColor = .label
    }
    
    private func configureBirthLabel() {
        view.addSubview(birthLabel)
        
        birthLabel.text = "\("date_birth".localized):"
        birthLabel.font = UIFont.systemFont(ofSize: 17)
        birthLabel.pinTop(to: colorLabel.bottomAnchor, 12)
        birthLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        birthLabel.textColor = .label
    }
    
    private func configureDatePickerBirth() {
        view.addSubview(datePickerBirth)
        
        datePickerBirth.datePickerMode = .date
        datePickerBirth.maximumDate = Date()
        datePickerBirth.date = pet.birth!
        datePickerBirth.translatesAutoresizingMaskIntoConstraints = false
        datePickerBirth.pinLeft(to: birthLabel.trailingAnchor, 5)
        datePickerBirth.pinCenterY(to: birthLabel.centerYAnchor)
        
    }
    
    private func configureLastVactLabel() {
        view.addSubview(lastVactLabel)
        
        lastVactLabel.text = "\("date_last_vaccinationsB".localized):"
        lastVactLabel.font = UIFont.systemFont(ofSize: 17)
        lastVactLabel.pinTop(to: birthLabel.bottomAnchor, 12)
        lastVactLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        lastVactLabel.textColor = .label
    }
    
    private func configureDatePickerLastVact() {
        view.addSubview(datePickerLastVact)
        
        datePickerLastVact.datePickerMode = .date
        if pet.lastVactination != "" {
            datePickerLastVact.date = dateFromString(pet.lastVactination!)
        }
        datePickerLastVact.maximumDate = Date()
        datePickerLastVact.translatesAutoresizingMaskIntoConstraints = false
        datePickerLastVact.pinLeft(to: lastVactLabel.trailingAnchor, 5)
        datePickerLastVact.pinCenterY(to: lastVactLabel.centerYAnchor)
        
    }
    
    private func configureYearVactLabel() {
        view.addSubview(yearVactLabel)
        
        yearVactLabel.text = "\("date_annualFirst_vaccinations".localized):"
        yearVactLabel.font = UIFont.systemFont(ofSize: 17)
        yearVactLabel.pinTop(to: lastVactLabel.bottomAnchor, 12)
        yearVactLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        yearVactLabel.textColor = .label
    }
    
    private func configureDatePickerYearVact() {
        view.addSubview(datePickerYearVact)
        
        
        datePickerYearVact.datePickerMode = .date
        if pet.yearVactination != "" {
            datePickerYearVact.date = dateFromString(pet.yearVactination!)
        }
        datePickerYearVact.maximumDate = Date()
        datePickerYearVact.translatesAutoresizingMaskIntoConstraints = false
        datePickerYearVact.pinLeft(to: yearVactLabel.trailingAnchor, 5)
        datePickerYearVact.pinCenterY(to: yearVactLabel.centerYAnchor)
        
    }
    
    private func configureLastBathLabel() {
        view.addSubview(lastBathLabel)
        
        lastBathLabel.text = "\("date_last_bathB".localized):"
        lastBathLabel.font = UIFont.systemFont(ofSize: 17)
        lastBathLabel.pinTop(to: yearVactLabel.bottomAnchor, 12)
        lastBathLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 22)
        lastBathLabel.textColor = .label
    }
    
    private func configureDatePickerLastBath() {
        view.addSubview(datePickerLastBath)
        
        datePickerLastBath.datePickerMode = .date
        if pet.lastBath != "" {
            datePickerLastBath.date = dateFromString(pet.lastBath!)
        }
      
        datePickerLastBath.maximumDate = Date()
        datePickerLastBath.translatesAutoresizingMaskIntoConstraints = false
        datePickerLastBath.pinLeft(to: lastBathLabel.trailingAnchor, 5)
        datePickerLastBath.pinCenterY(to: lastBathLabel.centerYAnchor)
        
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
            case .limited:
                break
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
        if nameField.text!.isEmpty {
            self.present(alert, animated: true)
        } else {
            self.present(editAlert, animated: true)
        }
    }
    
    @objc func deleteWasTapped() {
            self.present(alertDelete, animated: true)
        
    }
    
    @objc func agreeDeleteTapped() {
        interactor.removeForDB(date: pet.date!)
    }
    
    @objc func agreeButtonTapped(){
        interactor.addToDB(name: nameField.text!, type: typeField.text!, dateBirth: datePickerBirth.date, date: pet.date!, photo: imageView.image!, color: colorField.text!, breed: breedField.text!, lastVact: datePickerLastVact.date, yearVact: datePickerYearVact.date, lastBath: datePickerLastBath.date)
    }
   
    @objc func imageTapped() {
        if let image = imageView.image {
            fullScreenImageView = UIImageView(image: image)
            guard let fullScreenImageView = fullScreenImageView else { return }
            fullScreenImageView.frame = UIScreen.main.bounds
            fullScreenImageView.backgroundColor = .systemBackground
            fullScreenImageView.contentMode = .scaleAspectFit
            fullScreenImageView.isUserInteractionEnabled = true
            
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
            swipeGesture.direction = .down
            fullScreenImageView.addGestureRecognizer(swipeGesture)
            
            UIApplication.shared.keyWindow?.addSubview(fullScreenImageView)
            
            
        }
    }
    
    @objc func dismissFullScreenImage(sender: UISwipeGestureRecognizer) {
        guard let fullScreenImageView = fullScreenImageView else { return }
        UIView.animate(withDuration: 0.3, animations: {
            fullScreenImageView.transform = CGAffineTransform(translationX: 0, y: fullScreenImageView.frame.height)
        }) { _ in
            fullScreenImageView.removeFromSuperview()
        }
    }
    
    func dateFromString(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter.date(from: date)!
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

extension PetEditViewController: UITextFieldDelegate {
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

extension PetEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
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
