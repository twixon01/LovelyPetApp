//
//  CalendarEditInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

final class CalendarEditInteractor: CalendarEditBusinessLogic {
    // MARK: - Fields
    private let presenter: CalendarEditPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CalendarEditPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
}

