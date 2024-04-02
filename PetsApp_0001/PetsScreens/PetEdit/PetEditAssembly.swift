//
//  PetEditAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit

enum PetEditAssembly {
    static func build(pet: PetModel) -> UIViewController {
        let router: PetEditRouter = PetEditRouter()
        let presenter: PetEditPresenter = PetEditPresenter()
        let interactor: PetEditInteractor = PetEditInteractor(presenter: presenter)
        let viewController: PetEditViewController = PetEditViewController(
            router: router,
            interactor: interactor,
            pet: pet
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
