//
//  AccountSettingsViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

import UIKit
import Firebase

final class AccountSettingsViewController: UIViewController,
                                           AccountSettingsDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    
    private let label: UILabel = UILabel()
    private let emailLabel: UILabel = UILabel()
    private let changePasswordLabel: UILabel = UILabel()
    private let passwordLabel: UILabel = UILabel()
    private let passwordField: UITextField = UITextField()
    private let passwordLabel2: UILabel = UILabel()
    private let passwordField2: UITextField = UITextField()
    private let changePasswordButton: UIButton = UIButton()
    private let alert: UIAlertController = UIAlertController(title: "Ошибка смены пароля", message: "Пароль должен состоять минимум из 6 символов", preferredStyle: UIAlertController.Style.alert)
    
    private var user: UserModel = UserModel()
    
    private let router: AccountSettingsRoutingLogic
    private let interactor: AccountSettingsBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: AccountSettingsRoutingLogic,
        interactor: AccountSettingsBusinessLogic
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let agreeAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(agreeAction)
        
        interactor.userInfo{ [weak self] user in
            guard let self = self else { return }
            self.user = user
            interactor.loadStart(Model.Start.Request())
        }
        
        passwordField.delegate = self
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureLabel()
        configureEmailLabel()
        configureChangePasswordLabel()
        configurePasswordLabel()
        configurePasswordField()
        configurePasswordLabel2()
        configurePasswordField2()
        configurechangePasswordButton()
    }
    
    private func configureLabel() {
        view.addSubview(label)
        self.label.text = "hello".localized
        self.label.text?.append("\(user.name ?? "")!")
        label.numberOfLines = 2
        label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20).isActive = true
        self.label.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor,5)
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    private func configureEmailLabel() {
        view.addSubview(emailLabel)
        self.emailLabel.text = "your_email".localized
        
        let emailSep = user.email?.components(separatedBy: "@")
        
        emailLabel.text?.append("\(user.email?.prefix(4) ?? "")****@\(emailSep!.last ?? "")")
        emailLabel.textColor = .label
        self.emailLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        emailLabel.pinTop(to: label.bottomAnchor, 50)
        emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    private func configureChangePasswordLabel() {
        view.addSubview(changePasswordLabel)
        self.changePasswordLabel.text = "Смена пароля"
        
      
        changePasswordLabel.textColor = .label
        self.changePasswordLabel.font = UIFont(name:"SFProRounded-Black", size: 22.0)
        changePasswordLabel.pinTop(to: emailLabel.bottomAnchor, 50)
        changePasswordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    private func configurePasswordLabel() {
        view.addSubview(passwordLabel)
        self.passwordLabel.text = "Текущий пароль: "
        passwordLabel.textColor = .label
        self.passwordLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        passwordLabel.pinTop(to: changePasswordLabel.bottomAnchor, 15)
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    private func configurePasswordField() {
        view.addSubview(passwordField)
        
        passwordField.setWidth(240)
        passwordField.setHeight(35)
        passwordField.placeholder = "******"
        passwordField.isSecureTextEntry = true
        passwordField.font = UIFont.boldSystemFont(ofSize: 20)
        passwordField.pinLeft(to: passwordLabel.trailingAnchor, 6)
        passwordField.pinCenterY(to: passwordLabel.centerYAnchor)
        passwordField.returnKeyType = .done
        passwordField.textColor = .label
    }
    
    private func configurePasswordLabel2() {
        view.addSubview(passwordLabel2)
        self.passwordLabel2.text = "Новый пароль: "
        passwordLabel2.textColor = .label
        self.passwordLabel2.font = UIFont.boldSystemFont(ofSize: 20.0)
        passwordLabel2.pinTop(to: passwordLabel.bottomAnchor, 13)
        passwordLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
    }
    
    private func configurePasswordField2() {
        view.addSubview(passwordField2)
        
        passwordField2.setWidth(240)
        passwordField2.setHeight(35)
        passwordField2.placeholder = "******"
        passwordField2.isSecureTextEntry = true
        passwordField2.font = UIFont.boldSystemFont(ofSize: 20)
        passwordField2.pinLeft(to: passwordLabel2.trailingAnchor, 6)
        passwordField2.pinCenterY(to: passwordLabel2.centerYAnchor)
        passwordField2.returnKeyType = .done
        passwordField2.textColor = .label
    }
    
    private func configurechangePasswordButton() {
        view.addSubview(changePasswordButton)
        
        changePasswordButton.setTitle("Сменить пароль", for: .normal)
        changePasswordButton.setTitleColor(.white, for: .normal)
        changePasswordButton.backgroundColor = UIColor(named: "raspberryColor")
        changePasswordButton.layer.cornerRadius = 7
        changePasswordButton.pinTop(to: passwordField2.bottomAnchor, 25)
        changePasswordButton.pinCenterX(to: view)
        changePasswordButton.setWidth(350)
        changePasswordButton.setHeight(35)
        
        changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func changePassword() {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.changePasswordButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.changePasswordButton.transform = .identity
            }
        }
        if(passwordField.text!.isEmpty || passwordField2.text!.isEmpty){
            alert.message = "Заполните оба поля с паролем"
            self.present(alert, animated: true)
        } else if passwordField.text!.count < 6 || passwordField2.text!.count < 6 {
            alert.message = "Длина пароля должна быть не меньше 6 символов"
            self.present(alert, animated: true)
        }else{
            
            guard let user = Auth.auth().currentUser else {
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: passwordField.text!)
            print (user.email ?? "", passwordField.text!)
            
            user.reauthenticate(with: credential) { [self] result, error in
                if let error = error {
                    alert.message = "Текущий пароль недействителен"
                    self.present(alert, animated: true)
                    return
                }
                user.updatePassword(to: passwordField2.text!) { error in
                    if let error = error {
                        print("Ошибка смены пароля: \(error.localizedDescription)")
                    } else {
                        self.alert.title = "Пароль успешно изменен"
                        self.alert.message = nil
                        self.present(self.alert, animated: true)
                    }
                }
            }
        }
        
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
}

    // MARK: - Extensions
extension AccountSettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordField {
            passwordField2.becomeFirstResponder()
        } else if textField == passwordField2 {
            textField.resignFirstResponder()
        }
       
        return true
    }
}

extension AccountSettingsViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordField  || textField == passwordField2 {
            let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            textField.text = updatedString
            return false
        }
        return true
    }
}
