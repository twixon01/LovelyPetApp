//
//  CalendarInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class CalendarInteractor: CalendarBusinessLogic {
    // MARK: - Fields
    private let presenter: CalendarPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadCalendarAdd(_ request: Model.CalendarAdd.Request) {
        presenter.presentCalendarAdd(Model.CalendarAdd.Response())
    }
}

