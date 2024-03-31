//
//  SettingsInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

final class SettingsInteractor: SettingsBusinessLogic {
    // MARK: - Fields
    private let presenter: SettingsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadAuth(_ request: Model.AuthMy.Request) {
        presenter.presentAuth(Model.AuthMy.Response())
    }

    func loadJournal(_ request: Model.Journal.Request) {
        presenter.presentJournal(Model.Journal.Response())
    }
}

