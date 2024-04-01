//
//  CalendarEditPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

final class CalendarEditPresenter: CalendarEditPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: CalendarEditDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
}

