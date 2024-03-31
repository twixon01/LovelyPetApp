//
//  RegistrationAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

enum RegistrationAssembly {
    static func build() -> UIViewController {
        let router: RegistrationRouter = RegistrationRouter()
        let presenter: RegistrationPresenter = RegistrationPresenter()
        let interactor: RegistrationInteractor = RegistrationInteractor(presenter: presenter)
        let viewController: RegistrationViewController = RegistrationViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
