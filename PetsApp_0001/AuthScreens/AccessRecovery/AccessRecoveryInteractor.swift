//
//  AccessRecoveryInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class AccessRecoveryInteractor: AccessRecoveryBusinessLogic {
    // MARK: - Fields
    private let presenter: AccessRecoveryPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AccessRecoveryPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadResetPassword(_ request: Model.ResetPassword.Request) {
        presenter.presentResetPassword(Model.ResetPassword.Response())
    }
}

