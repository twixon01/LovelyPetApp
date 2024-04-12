//
//  CalendarAddAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

import UIKit

enum CalendarAddAssembly {
    static func build() -> UIViewController {
        let router: CalendarAddRouter = CalendarAddRouter()
        let presenter: CalendarAddPresenter = CalendarAddPresenter()
        let interactor: CalendarAddInteractor = CalendarAddInteractor(presenter: presenter)
        let viewController: CalendarAddViewController = CalendarAddViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
