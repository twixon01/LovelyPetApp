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
    
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    
    func presentJournalAdd(_ response: Model.JournalAdd.Response) {
        view?.displayJournalAdd(Model.JournalAdd.ViewModel())
    }
    
    func presentJournalEdit(_ response: Model.JournalEdit.Response) {
        view?.displayJournalEdit(Model.JournalEdit.ViewModel(event: response.event))
    }
}


