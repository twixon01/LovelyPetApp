//
//  AuthPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class AuthPresenter: AuthPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: AuthDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentAccessRecovery(_ response: Model.AccessRecovery.Response) {
        view?.displayAccessRecovery(Model.AccessRecovery.ViewModel())
    }
    
    func presentRegistration(_ response: Model.Registration.Response) {
        view?.displayRegistration(Model.Registration.ViewModel())
    }
    
    func presentJournal(_ response: Model.Journal.Response) {
        view?.displayJournal(Model.Journal.ViewModel())
    }
}

