//
//  PetPageAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit

enum PetPageAssembly {
    static func build(pet: PetModel) -> UIViewController {
        let router: PetPageRouter = PetPageRouter()
        let presenter: PetPagePresenter = PetPagePresenter()
        let interactor: PetPageInteractor = PetPageInteractor(presenter: presenter)
        let viewController: PetPageViewController = PetPageViewController(
            router: router,
            interactor: interactor,
            pet: pet
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
