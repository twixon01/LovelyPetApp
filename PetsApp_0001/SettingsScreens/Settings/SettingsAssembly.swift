//
//  SettingsAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum SettingsAssembly {
    static func build() -> UIViewController {
        let router: SettingsRouter = SettingsRouter()
        let presenter: SettingsPresenter = SettingsPresenter()
        let interactor: SettingsInteractor = SettingsInteractor(presenter: presenter)
        let viewController: SettingsViewController = SettingsViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
