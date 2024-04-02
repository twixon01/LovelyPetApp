//
//  JournalAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

enum JournalAssembly {
    static func build() -> UIViewController {
        let router: JournalRouter = JournalRouter()
        let presenter: JournalPresenter = JournalPresenter()
        let interactor: JournalInteractor = JournalInteractor(presenter: presenter)
        let viewController: JournalViewController = JournalViewController(
            router: router,
            interactor: interactor, presenter: presenter
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
