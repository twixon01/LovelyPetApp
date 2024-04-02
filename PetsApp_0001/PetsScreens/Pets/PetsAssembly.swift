//
//  PetsAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum PetsAssembly {
    static func build() -> UIViewController {
        let router: PetsRouter = PetsRouter()
        let presenter: PetsPresenter = PetsPresenter()
        let interactor: PetsInteractor = PetsInteractor(presenter: presenter)
        let viewController: PetsViewController = PetsViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
