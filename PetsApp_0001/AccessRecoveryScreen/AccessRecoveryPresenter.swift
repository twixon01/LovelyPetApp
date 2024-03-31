//
//  AccessRecoveryPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

final class AccessRecoveryPresenter: AccessRecoveryPresentationLogic {
    
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: AccessRecoveryDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentResetPassword(_ response: Model.ResetPassword.Response) {
        view?.displayResetPassword(Model.ResetPassword.ViewModel())
    }
}

