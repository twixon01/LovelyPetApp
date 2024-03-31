//
//  AccessRecoveryViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

final class AccessRecoveryViewController: UIViewController,
                                          AccessRecoveryDisplayLogic, UIGestureRecognizerDelegate {
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let textLabel: UILabel = UILabel()
    private let mailTextField: CustomTextField = CustomTextField(placeholder: "mail_field".localized)
    private let resetPasswordButton: UIButton = UIButton()
    private let alert: UIAlertController = UIAlertController(title: "password_reset_alert".localized, message: "password_reset_alert_2".localized, preferredStyle: UIAlertController.Style.alert)
    private let alertError: UIAlertController = UIAlertController(title: "Я великий грешник, простите меня", message: "error_reset_password".localized, preferredStyle: UIAlertController.Style.alert)
    private let label: UILabel = UILabel()
    
    private let router: AccessRecoveryRoutingLogic
    private let interactor: AccessRecoveryBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: AccessRecoveryRoutingLogic,
        interactor: AccessRecoveryBusinessLogic
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
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.okWasTapped()
        }
        let skipAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        alertError.addAction(skipAction)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureLabel()
        configureTextLabel()
        configureMailTextField()
        configureResetPasswordButton()
    }
    
    private func configureLabel() {
        view.addSubview(label)
        
        label.text = "password_reset".localized
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 240)
        label.pinCenterX(to: view)
    }
    
    private func configureTextLabel() {
        view.addSubview(textLabel)
        
        textLabel.text = "reset_password_instr".localized
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.setWidth(350)
        textLabel.pinCenterX(to: view)
        textLabel.pinTop(to: label.bottomAnchor, 10)
    }
    
    private func configureMailTextField() {
        view.addSubview(mailTextField)
        
        mailTextField.pinTop(to: textLabel.bottomAnchor, 20)
        mailTextField.pinCenterX(to: view)
        mailTextField.setWidth(350)
        mailTextField.setHeight(35)
        
        mailTextField.textColor = .label
    }
    
    private func configureResetPasswordButton() {
        view.addSubview(resetPasswordButton)
        
        resetPasswordButton.setTitle("reset_password".localized, for: .normal)
        resetPasswordButton.setTitleColor(.white, for: .normal)
        resetPasswordButton.backgroundColor = .systemBlue
        resetPasswordButton.layer.cornerRadius = 7
        resetPasswordButton.pinTop(to: mailTextField.bottomAnchor, 15)
        resetPasswordButton.pinCenterX(to: view)
        resetPasswordButton.setWidth(350)
        resetPasswordButton.setHeight(40)
        
        resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func resetPassword() {
        
        UIView.animate(withDuration: 0.1, animations: {
                self.resetPasswordButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.resetPasswordButton.transform = .identity
                }
            }
        
        let email = mailTextField.text!
        if(!email.isEmpty){
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil{
                    self.present(self.alertError, animated: true)
                }
            }
            self.present(alert, animated: true)
        }
        else{
            self.present(alertError, animated: true)
        }
    }
    
    private func okWasTapped() {
        interactor.loadResetPassword(AccessRecoveryModel.ResetPassword.Request())
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayResetPassword(_ viewModel: Model.ResetPassword.ViewModel) {
        router.routeToResetPassword()
    }
}
