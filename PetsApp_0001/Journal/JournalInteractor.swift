//
//  JournalInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import Firebase

final class JournalInteractor: JournalBusinessLogic {

    
    // MARK: - Fields
    private let presenter: JournalPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: JournalPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadSettings(_ request: Model.Settings.Request) {
        presenter.presentSettings(Model.Settings.Response())
    }
    
    func loadPets(_ request: Model.Pets.Request) {
        presenter.presentPets(Model.Pets.Response())
    }
    
    func loadCalendar(_ request: Model.Calendar.Request) {
        presenter.presentCalendar(Model.Calendar.Response())
    }
    
    func loadJournalAdd(_ request: Model.JournalAdd.Request) {
        presenter.presentJournalAdd(Model.JournalAdd.Response())
    }
    
    func loadJournalEdit(_ request: Model.JournalEdit.Request) {
        presenter.presentJournalEdit(Model.JournalEdit.Response(event: request.event))
    }
}

