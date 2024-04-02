//
//  JournalAddAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum JournalAddAssembly {
    static func build() -> UIViewController {
        let router: JournalAddRouter = JournalAddRouter()
        let presenter: JournalAddPresenter = JournalAddPresenter()
        let interactor: JournalAddInteractor = JournalAddInteractor(presenter: presenter)
        let viewController: JournalAddViewController = JournalAddViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
