//
//  JournalEditPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

final class JournalEditPresenter: JournalEditPresentationLogic {
    
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: JournalEditDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentJournal(_ response: Model.Journal.Response) {
        view?.displayJournal(Model.Journal.ViewModel())
    }
}

