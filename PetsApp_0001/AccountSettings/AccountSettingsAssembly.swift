//
//  AccountSettingsAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

import UIKit

enum AccountSettingsAssembly {
    static func build() -> UIViewController {
        let router: AccountSettingsRouter = AccountSettingsRouter()
        let presenter: AccountSettingsPresenter = AccountSettingsPresenter()
        let interactor: AccountSettingsInteractor = AccountSettingsInteractor(presenter: presenter)
        let viewController: AccountSettingsViewController = AccountSettingsViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
