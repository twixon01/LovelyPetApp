//
//  AuthController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

final class AuthViewController: UIViewController, AuthDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
        static let logoName: String = "launchScreenLogo"
        static let appName: String = "nameForAuth"
    }
    
    // MARK: - Fields
    private let logo: UIImageView = UIImageView(image: UIImage(named: Constants.logoName))
    private let nameApp: UIImageView = UIImageView(image: UIImage(named: Constants.appName))
    private let mailTextField: CustomTextField = CustomTextField(placeholder: "mail_field".localized)
    private let passwordTextField: CustomTextField = CustomTextField(placeholder: "password_field".localized)
    private let label: UILabel = UILabel()
    private let logInButton: UIButton = UIButton()
    private let forgotPasswordTextView: UILabel = UILabel()
    private let noAccountTextView: UILabel = UILabel()
    private let accessRecoveryButton: UIButton = UIButton()
    private let registrationButton: UIButton = UIButton()
    private let alert: UIAlertController = UIAlertController(title: "Ошибка авторизации", message: "Неверный логин или пароль", preferredStyle: UIAlertController.Style.alert)
    
    private let router: AuthRoutingLogic
    private let interactor: AuthBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: AuthRoutingLogic,
        interactor: AuthBusinessLogic
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
        navigationController?.setToolbarHidden(true, animated: false)
        self.navigationItem.hidesBackButton = true
        interactor.loadStart(Model.Start.Request())
        let agreeAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(agreeAction)
        
        mailTextField.delegate = self
        passwordTextField.delegate = self
        
        hidesBottomBarWhenPushed = true
    }
    // MARK: - Configuration
    private func configureUI() {
        configureLogo()
        configureNameApp()
        configureLabel()
        configureMailTextField()
        configurePasswordTextField()
        configureLogInButton()
        configurePasswordTextField()
        configureForgotPasswordTextView()
        configureNoAccountTextView()
        configureAccessRecoveryButton()
        configureRegistrationButton()
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
        
        label.text = "authorization".localized
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.pinTop(to: nameApp.bottomAnchor, 20)
        label.pinCenterX(to: view)
    }
    
    private func configureMailTextField() {
        view.addSubview(mailTextField)
        
        mailTextField.pinTop(to: label.bottomAnchor, 20)
        mailTextField.pinCenterX(to: view)
        mailTextField.setWidth(350)
        mailTextField.setHeight(40)

        mailTextField.returnKeyType = .done
        mailTextField.textColor = .label
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.pinTop(to: mailTextField.bottomAnchor, 10)
        passwordTextField.pinCenterX(to: view)
        passwordTextField.setWidth(350)
        passwordTextField.setHeight(40)
        
        passwordTextField.isSecureTextEntry = true
        
        
        passwordTextField.returnKeyType = .done
        
        passwordTextField.textColor = .label
    }
    
    private func configureLogInButton() {
        view.addSubview(logInButton)
        
        logInButton.setTitle("log_in".localized, for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .systemBlue
        logInButton.layer.cornerRadius = 7
        logInButton.pinTop(to: passwordTextField.bottomAnchor, 20)
        logInButton.pinCenterX(to: view)
        logInButton.setWidth(350)
        logInButton.setHeight(35)
        
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
    }
    
    private func configureForgotPasswordTextView() {
        view.addSubview(forgotPasswordTextView)
        
        forgotPasswordTextView.text = "Забыли пароль?"
        forgotPasswordTextView.pinTop(to: logInButton.bottomAnchor, 20)
        forgotPasswordTextView.pinLeft(to: logInButton.leadingAnchor)
        forgotPasswordTextView.textColor = .label
    }
    
    private func configureNoAccountTextView() {
        view.addSubview(noAccountTextView)
        
        noAccountTextView.text = "Нет аккаунта?"
        noAccountTextView.pinTop(to: forgotPasswordTextView.bottomAnchor, 10)
        noAccountTextView.pinLeft(to: logInButton.leadingAnchor)
        noAccountTextView.textColor = .label
    }
    
    private func configureAccessRecoveryButton() {
        view.addSubview(accessRecoveryButton)
        
        accessRecoveryButton.setTitle("Восстановление доступа", for: .normal)
        accessRecoveryButton.backgroundColor = .clear
        accessRecoveryButton.setTitleColor(.systemBlue, for: .normal)
        accessRecoveryButton.pinLeft(to: forgotPasswordTextView.trailingAnchor, 5)
        accessRecoveryButton.pinCenterY(to: forgotPasswordTextView.centerYAnchor)
        
        accessRecoveryButton.addTarget(self, action: #selector(accessRecovery), for: .touchUpInside)
        accessRecoveryButton.addTarget(self, action: #selector(handleButtonHighlight), for: .touchDown)
    }
    
    private func configureRegistrationButton() {
        view.addSubview(registrationButton)
        
        registrationButton.setTitle("registration".localized, for: .normal)
        registrationButton.backgroundColor = .clear
        registrationButton.setTitleColor(.systemBlue, for: .normal)
        registrationButton.pinLeft(to: noAccountTextView.trailingAnchor, 5)
        registrationButton.pinCenterY(to: noAccountTextView.centerYAnchor)
        
        registrationButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(handleButtonHighlight), for: .touchDown)
    }
    
    // MARK: - Actions
    @objc
    private func logIn() {
        
        UIView.animate(withDuration: 0.1, animations: {
                self.logInButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logInButton.transform = .identity
                }
            }
        if(!passwordTextField.text!.isEmpty){
            Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error == nil{
                    self.interactor.loadJournal(AuthModel.Journal.Request())
                }
                else {
                    self.present(self.alert, animated: true)
                }
                
            }
        }
    }
    
    @objc private func handleButtonHighlight(sender: UIButton) {
        sender.setTitleColor(.gray, for: .highlighted)
    }
    
    @objc
    private func accessRecovery() {
        interactor.loadAccessRecovery(AuthModel.AccessRecovery.Request())
    }
    
    @objc
    private func signUp() {
        
        interactor.loadRegistration(AuthModel.Registration.Request())
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayAccessRecovery(_ viewModel: Model.AccessRecovery.ViewModel) {
        router.routeToAccessRecovery()
    }
    
    func displayRegistration(_ viewModel: Model.Registration.ViewModel) {
        router.routeToRegistration()
    }
    
    func displayJournal(_ viewModel: Model.Journal.ViewModel) {
        router.routeToJournal()
    }
}

    // MARK: - Extensions
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension AuthViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            textField.text = updatedString
            return false
        }
        return true
    }
}


