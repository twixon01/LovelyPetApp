//
//  CalendarAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

enum CalendarAssembly {
    static func build() -> UIViewController {
        let router: CalendarRouter = CalendarRouter()
        let presenter: CalendarPresenter = CalendarPresenter()
        let interactor: CalendarInteractor = CalendarInteractor(presenter: presenter)
        let viewController: CalendarViewController = CalendarViewController(
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
