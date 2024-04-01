//
//  AccountSettingsInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

final class AccountSettingsInteractor: AccountSettingsBusinessLogic {
    // MARK: - Fields
    private let presenter: AccountSettingsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AccountSettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
}

