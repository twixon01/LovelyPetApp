//
//  RegistrationViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

final class RegistrationViewController: UIViewController,
                                        RegistrationDisplayLogic, UIGestureRecognizerDelegate {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
        static let logoName: String = "launchScreenLogo"
        static let appName: String = "nameForAuth"
    }
    
    // MARK: - Fields
    private let logo: UIImageView = UIImageView(image: UIImage(named: Constants.logoName))
    private let nameApp: UIImageView = UIImageView(image: UIImage(named: Constants.appName))
    private let label: UILabel = UILabel()
    private let regButton: UIButton = UIButton()
    private let nameField: CustomTextField = CustomTextField(placeholder: "name_field".localized)
    private let mailField: CustomTextField = CustomTextField(placeholder: "mail_field".localized)
    private let passwordField: CustomTextField = CustomTextField(placeholder: "password_6chars".localized)
    private let passwordField2: CustomTextField = CustomTextField(placeholder: "repeat_password".localized)
    private let alert: UIAlertController = UIAlertController(title: "error_alert".localized, message: nil, preferredStyle: UIAlertController.Style.alert)
    
    private let router: RegistrationRoutingLogic
    private let interactor: RegistrationBusinessLogic
    

    
    
    // MARK: - LifeCycle
    init(
        router: RegistrationRoutingLogic,
        interactor: RegistrationBusinessLogic
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
        self.navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let goodAction = UIAlertAction(title: "ОК", style: .default){ _ in
//            self.interactor.loadJournal(RegistrationModel.Journal.Request())
        }
        self.alert.addAction(goodAction)
        interactor.loadStart(Model.Start.Request())
        
        nameField.delegate = self
        mailField.delegate = self
        passwordField.delegate = self
        passwordField2.delegate = self
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureLogo()
        configureNameApp()
        configureLabel()
        configureNameField()
        configureMailField()
        configurePasswordField()
        configurePasswordField2()
        configureRegButton()
    }
    
    private func configureLogo() {
        view.addSubview(logo)
        self.logo.layer.masksToBounds = true
        logo.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        logo.pinCenterX(to: view)
        logo.setWidth(190)
        logo.setHeight(190)
    }
    
    private func configureNameApp() {
        view.addSubview(nameApp)
        self.nameApp.layer.masksToBounds = true
        nameApp.pinTop(to: logo.bottomAnchor, 10)
        nameApp.pinCenterX(to: view)
        nameApp.setWidth(106.25)
        nameApp.setHeight(41.875)
    }
    
    private func configureLabel() {
        view.addSubview(label)
        
        label.text = "registration".localized
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.pinTop(to: nameApp.bottomAnchor, 20)
        label.pinCenterX(to: view)
    }
    
    private func configureNameField() {
        view.addSubview(nameField)
        
        nameField.setWidth(350)
        nameField.setHeight(40)
        nameField.pinTop(to: label.bottomAnchor, 20)
        nameField.pinCenterX(to: view)
        
        nameField.returnKeyType = .done
        nameField.textColor = .label
    }
    
    private func configureMailField() {
        view.addSubview(mailField)
        
        mailField.setWidth(350)
        mailField.setHeight(40)
        mailField.pinTop(to: nameField.bottomAnchor, 10)
        mailField.pinCenterX(to: view)
        
        mailField.returnKeyType = .done
        mailField.textColor = .label
    }
    
    private func configurePasswordField() {
        view.addSubview(passwordField)
        
        passwordField.setWidth(350)
        passwordField.setHeight(40)
        passwordField.pinTop(to: mailField.bottomAnchor, 10)
        passwordField.pinCenterX(to: view)
        
        passwordField.returnKeyType = .done
        
        passwordField.isSecureTextEntry = true
        passwordField.textColor = .label
        
    }
    
    private func configurePasswordField2() {
        view.addSubview(passwordField2)
        
        passwordField2.setWidth(350)
        passwordField2.setHeight(40)
        passwordField2.pinTop(to: passwordField.bottomAnchor, 10)
        passwordField2.pinCenterX(to: view)
        
        passwordField2.returnKeyType = .done
        
        passwordField2.isSecureTextEntry = true
        passwordField2.textColor = .label
        
    }
    
    private func configureRegButton() {
        view.addSubview(regButton)
        
        regButton.setWidth(350)
        regButton.setHeight(35)
        regButton.setTitle("create_account_button".localized, for: .normal)
        regButton.setTitleColor(.white, for: .normal)
        regButton.backgroundColor = .systemBlue
        regButton.layer.cornerRadius = 7
        regButton.pinTop(to: passwordField2.bottomAnchor, 20)
        regButton.pinCenterX(to: view)
        
        regButton.addTarget(self, action: #selector(wasTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
        UIView.animate(withDuration: 0.1, animations: {
                self.regButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.regButton.transform = .identity
                }
            }
        
        
        interactor.authenticateUser(name: nameField.text!, email: mailField.text!, password: passwordField.text!, password2 : passwordField2.text!){ success, errorMessage in
            if !success {
                if (errorMessage == "The email address is badly formatted.")
                {
                    self.alert.message = "Недействительный адрес электронной почты"
                }else if (errorMessage == "password"){
                    self.alert.message = "Введенные пароли не совпадают"
                }else if (errorMessage == "The password must be 6 characters long or more."){
                    self.alert.message = "Пароль должен состоять из 6 и более символов"
                }else if (errorMessage == "The email address is already in use by another account."){
                    self.alert.message = "Данный электронный адрес уже занят"
                }else if (errorMessage == ""){
                    self.alert.message = "Заполните все поля"
                }else{
                    self.alert.message = errorMessage
                }
                self.present(self.alert, animated: true)
            }
        }
        
                                    
       
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayJournal(_ viewModel: Model.Journal.ViewModel) {
        router.routeToJournal()
    }
}

    // MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            mailField.becomeFirstResponder()
        }
        else if textField == mailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField2.becomeFirstResponder()
        }else if textField == passwordField2 {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension RegistrationViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordField{
            let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            textField.text = updatedString
            return false
        }else if textField == passwordField2 {
            let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            textField.text = updatedString
            return false
        }
        return true
    }
}

