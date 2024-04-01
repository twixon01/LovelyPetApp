//
//  JournalEditAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit

enum JournalEditAssembly {
    static func build() -> UIViewController {
        let router: JournalEditRouter = JournalEditRouter()
        let presenter: JournalEditPresenter = JournalEditPresenter()
        let interactor: JournalEditInteractor = JournalEditInteractor(presenter: presenter)
        let viewController: JournalEditViewController = JournalEditViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
