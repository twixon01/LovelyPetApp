//
//  AccessRecoveryAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

enum AccessRecoveryAssembly {
    static func build() -> UIViewController {
        let router: AccessRecoveryRouter = AccessRecoveryRouter()
        let presenter: AccessRecoveryPresenter = AccessRecoveryPresenter()
        let interactor: AccessRecoveryInteractor = AccessRecoveryInteractor(presenter: presenter)
        let viewController: AccessRecoveryViewController = AccessRecoveryViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
