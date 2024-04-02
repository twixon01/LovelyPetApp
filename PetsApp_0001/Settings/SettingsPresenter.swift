//
//  SettingsPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Fields
    
    weak var view: SettingsDisplayLogic?
    weak var viewController: SettingsViewController?
    
    // MARK: - PresentationLogic
    
    func presentAuth(_ response: Model.AuthMy.Response) {
        view?.displayAuth(Model.AuthMy.ViewModel())
    }
    
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentAccountSettings(_ response: Model.AccountSettings.Response) {
        view?.displayAccountSettings(Model.AccountSettings.ViewModel())
    }
}

