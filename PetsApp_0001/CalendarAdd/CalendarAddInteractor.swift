//
//  CalendarAddInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

final class CalendarAddInteractor: CalendarAddBusinessLogic {
    // MARK: - Fields
    private let presenter: CalendarAddPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CalendarAddPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
}

