//
//  AuthAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

enum AuthAssembly {
    static func build() -> UIViewController {
        let router: AuthRouter = AuthRouter()
        let presenter: AuthPresenter = AuthPresenter()
        let interactor: AuthInteractor = AuthInteractor(presenter: presenter)
        let viewController: AuthViewController = AuthViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        viewController.hidesBottomBarWhenPushed = true
        
        return viewController
    }
}
