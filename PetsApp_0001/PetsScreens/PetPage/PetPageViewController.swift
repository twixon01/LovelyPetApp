//
//  PetPageViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit
import Photos

final class PetPageViewController: UIViewController,
                                   PetPageDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let imageView: UIImageView = UIImageView()
    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let nameLabel: UILabel = UILabel()
    private let typeBreedLabel: UILabel = UILabel()
    private let breedLabel: UILabel = UILabel()
    private let breedField: UITextField = UITextField()
    private let colorLabel: UILabel = UILabel()
    private let ageLabel: UILabel = UILabel()
    private let birthLabel: UILabel = UILabel()
    private let birthLabel2: UILabel = UILabel()
    private let datePicker   = UIDatePicker()
    private let addButton: UIButton = UIButton()
    private let infoLabel: UILabel = UILabel()
    private let yearVact: UILabel = UILabel()
    private let lastVact: UILabel = UILabel()
    private let lastBath: UILabel = UILabel()
    private var fullScreenImageView: UIImageView?
    private let alert: UIAlertController = UIAlertController(title: "error_alert".localized, message: "Fill_required_field_name".localized, preferredStyle: UIAlertController.Style.alert)
    
    private let pet: PetModel
    
    private let router: PetPageRoutingLogic
    private let interactor: PetPageBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: PetPageRoutingLogic,
        interactor: PetPageBusinessLogic,
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
        
        interactor.loadStart(Model.Start.Request())
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        let doneButton = UIBarButtonItem(title: "edit".localized, style: .plain, target: self, action: #selector(editButtonTapped))
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureImageView()
        configureNameLabel()
        configureTypeBreedLabel()
        configureAgeLabel()
        configureBirthLabel1()
        configureBirthLabel2()
        configureInfoLabel()
        configureColorLabel()
        configureYearVactLabel()
        configureLastVactLabel()
        configureYearLastBathLabel()
        
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.setWidth(160)
        imageView.setHeight(160)
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        imageView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor,6)
        //imageView.image = UIImage(named: "no_photo")
        imageView.image = pet.image
    }
    
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "\(pet.name)"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 45)
        nameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 2)
        nameLabel.pinLeft(to: imageView.trailingAnchor, 10)
        nameLabel.textColor = .label
        nameLabel.setWidth(255)
    }
    
    
    private func configureTypeBreedLabel() {
        view.addSubview(typeBreedLabel)
        if !pet.type!.isEmpty && !pet.breed!.isEmpty {
            typeBreedLabel.text = "\(pet.type!.capitalized), \(pet.breed!)"
        }else if !pet.type!.isEmpty {
            typeBreedLabel.text = "\(pet.type!.capitalized)"
        } else if !pet.breed!.isEmpty{
            typeBreedLabel.text = "\(pet.breed!.capitalized)"
        }
        
        typeBreedLabel.font = UIFont.systemFont(ofSize: 16)
        typeBreedLabel.pinTop(to: nameLabel.topAnchor, 70)
        typeBreedLabel.pinLeft(to: nameLabel.leadingAnchor)
        typeBreedLabel.textColor = .label
    }
    
    private func configureAgeLabel() {
        view.addSubview(ageLabel)
        
        let ageComponents = Calendar.current.dateComponents([.year, .month], from: pet.birth!, to: Date())
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let sizeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: "age".localized, attributes: sizeAttributes)
        var ageString : String = String()
        if ageComponents.year! < 1 {
            let age = ageComponents.month
            if age! < 1 {
                ageString = "less_than_month".localized
            }else if age! % 10 == 1{
                ageString = "\(age!) "
                ageString += "month_base".localized
            } else if age! % 10 < 5 {
                ageString = "\(age!) "
                ageString += "monthA".localized
                
            } else if age! % 10 > 5{
                ageString = "\(age!) "
                ageString += "monthsB".localized
            }
        }
        else {
            let age = ageComponents.year
            if age! == 11 {
                ageString = "\(age!) "
                ageString += "yearsB".localized
            } else if age! % 10 == 0 {
                ageString = "\(age!) "
                ageString += "yearsB".localized
            }
            else if age! % 10 == 1 {
                ageString = "\(age!) "
                ageString += "yearA".localized
            } else if age! % 10 < 5 {
                ageString = "\(age!) "
                ageString += "yearsA".localized
            } else {
                ageString = "\(age!) "
                ageString += "yearsB".localized
            }
        }
        
        let ageAttributedString = NSAttributedString(string: ageString, attributes: boldAttributes)
        attributedText.append(ageAttributedString)
        
        ageLabel.attributedText = attributedText
        ageLabel.pinTop(to: typeBreedLabel.topAnchor, 39)
        ageLabel.pinLeft(to: nameLabel.leadingAnchor)
    }
    
    private func configureBirthLabel1() {
        view.addSubview(birthLabel)
        
        
        birthLabel.text = "date_birth2".localized
        birthLabel.font = UIFont.systemFont(ofSize: 16)
        
        birthLabel.pinBottom(to: imageView.bottomAnchor)
        birthLabel.pinLeft(to:  nameLabel.leadingAnchor)
        
    }
    
    private func configureBirthLabel2() {
        view.addSubview(birthLabel2)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMM yyyy"
        let birthDate = dateFormatter.string(from: pet.birth!)
        
        
        birthLabel2.text = birthDate
        birthLabel2.font = UIFont.boldSystemFont(ofSize: 16)
        
        birthLabel2.pinBottom(to: imageView.bottomAnchor)
        birthLabel2.pinLeft(to: birthLabel.trailingAnchor, 2)
        
    }
    
    private func configureInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.text = "other_information".localized
        infoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        infoLabel.pinTop(to: imageView.bottomAnchor, 30)
        infoLabel.pinLeft(to: imageView.leadingAnchor, 8)
        infoLabel.textColor = .label
    }
    
    private func configureColorLabel() {
        view.addSubview(colorLabel)
        
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let sizeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: "colorPet".localized, attributes: sizeAttributes)
        
        let ageAttributedString = NSAttributedString(string: pet.color!, attributes: boldAttributes)
        attributedText.append(ageAttributedString)
        
        colorLabel.attributedText = attributedText
        colorLabel.pinTop(to: infoLabel.bottomAnchor, 12)
        colorLabel.pinLeft(to: infoLabel.leadingAnchor)
    }
    
    private func configureYearVactLabel() {
        view.addSubview(yearVact)
        
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let sizeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: "date_annual_vaccinations".localized, attributes: sizeAttributes)
        
        let ageAttributedString = NSAttributedString(string: pet.yearVactination!, attributes: boldAttributes)
        attributedText.append(ageAttributedString)
        
        yearVact.attributedText = attributedText
        yearVact.pinTop(to: colorLabel.bottomAnchor, 8)
        yearVact.pinLeft(to: infoLabel.leadingAnchor)
    }
    
    private func configureLastVactLabel() {
        view.addSubview(lastVact)
        
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let sizeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: "date_last_vaccinations".localized, attributes: sizeAttributes)
        
        let ageAttributedString = NSAttributedString(string: pet.lastVactination!, attributes: boldAttributes)
        attributedText.append(ageAttributedString)
        
        lastVact.attributedText = attributedText
        lastVact.pinTop(to: yearVact.bottomAnchor, 8)
        lastVact.pinLeft(to: infoLabel.leadingAnchor)
    }
    
    private func configureYearLastBathLabel() {
        view.addSubview(lastBath)
        
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let sizeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: "date_last_bath".localized, attributes: sizeAttributes)
        
        let ageAttributedString = NSAttributedString(string: pet.lastBath!, attributes: boldAttributes)
        attributedText.append(ageAttributedString)
        
        lastBath.attributedText = attributedText
        lastBath.pinTop(to: lastVact.bottomAnchor, 8)
        lastBath.pinLeft(to: infoLabel.leadingAnchor)
    }
    
    
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
    
    @objc func editButtonTapped() {
        interactor.loadPetEdit(PetPageModel.Pets.Request(pet: pet))
    }
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayPetEdit(_ viewModel: Model.Pets.ViewModel) {
        router.routeToPetEdit(pet: viewModel.pet)
    }
}

// MARK: - Extensions

extension PetPageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
