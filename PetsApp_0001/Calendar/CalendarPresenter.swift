//
//  CalendarPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class CalendarPresenter: CalendarPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: CalendarDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentCalendarAdd(_ response: Model.CalendarAdd.Response) {
        view?.displayCalendarAdd(Model.CalendarAdd.ViewModel())
    }
}
