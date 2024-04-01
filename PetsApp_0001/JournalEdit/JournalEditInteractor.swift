//
//  JournalEditInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

final class JournalEditInteractor: JournalEditBusinessLogic {
    // MARK: - Fields
    private let presenter: JournalEditPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: JournalEditPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
}

