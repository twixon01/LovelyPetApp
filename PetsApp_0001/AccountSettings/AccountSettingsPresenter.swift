//
//  AccountSettingsPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

final class AccountSettingsPresenter: AccountSettingsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: AccountSettingsDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
}

