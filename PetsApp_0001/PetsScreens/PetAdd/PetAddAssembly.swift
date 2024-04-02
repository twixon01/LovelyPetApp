//
//  PetAddAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum PetAddAssembly {
    static func build() -> UIViewController {
        let router: PetAddRouter = PetAddRouter()
        let presenter: PetAddPresenter = PetAddPresenter()
        let interactor: PetAddInteractor = PetAddInteractor(presenter: presenter)
        let viewController: PetAddViewController = PetAddViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
