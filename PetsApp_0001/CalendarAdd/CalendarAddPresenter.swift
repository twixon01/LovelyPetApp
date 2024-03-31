//
//  CalendarAddPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

final class CalendarAddPresenter: CalendarAddPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: CalendarAddDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
}

