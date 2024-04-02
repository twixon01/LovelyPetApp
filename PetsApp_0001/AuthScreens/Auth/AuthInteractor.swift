//
//  AuthInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class AuthInteractor: AuthBusinessLogic {
    // MARK: - Fields
    private let presenter: AuthPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AuthPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadAccessRecovery(_ request: Model.AccessRecovery.Request) {
        presenter.presentAccessRecovery(Model.AccessRecovery.Response())
    }
    
    func loadRegistration(_ request: Model.Registration.Request) {
        presenter.presentRegistration(Model.Registration.Response())
    }
    
    func loadJournal(_ request: Model.Journal.Request) {
        presenter.presentJournal(Model.Journal.Response())
    }
}
