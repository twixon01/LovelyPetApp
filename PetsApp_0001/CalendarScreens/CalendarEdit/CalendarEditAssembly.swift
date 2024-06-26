//
//  CalendarEditAssembly.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

import UIKit

enum CalendarEditAssembly {
    static func build(event: CalendarEventModel) -> UIViewController {
        let router: CalendarEditRouter = CalendarEditRouter()
        let presenter: CalendarEditPresenter = CalendarEditPresenter()
        let interactor: CalendarEditInteractor = CalendarEditInteractor(presenter: presenter)
        let viewController: CalendarEditViewController = CalendarEditViewController(
            event: event,
            router: router,
            interactor: interactor
        )
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
