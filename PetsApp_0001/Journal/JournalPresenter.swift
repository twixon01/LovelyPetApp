//
//  JournalPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class JournalPresenter: JournalPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: JournalDisplayLogic?
    weak var viewController: JournalViewController?
    
    
    // MARK: - PresentationLogic
    
    func presentSettings(_ response: Model.Settings.Response) {
        view?.displaySettings(Model.Settings.ViewModel())
    }
    
    func presentPets(_ response: Model.Pets.Response) {
        view?.displayPets(Model.Pets.ViewModel())
    }
    
    
    
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    
    func presentCalendar(_ response: Model.Calendar.Response) {
        view?.displayCalendar(Model.Calendar.ViewModel())
    }
    
    func presentJournalAdd(_ response: Model.JournalAdd.Response) {
        view?.displayJournalAdd(Model.JournalAdd.ViewModel())
    }
    
}


