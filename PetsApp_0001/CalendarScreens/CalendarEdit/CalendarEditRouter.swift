//
//  CalendarEditRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

import UIKit

final class CalendarEditRouter: CalendarEditRoutingLogic {
    weak var view: UIViewController?
    
    func routeToCalendar() {
        guard let calendarViewController = view?.navigationController?.viewControllers
                    .compactMap({ $0 as? CalendarViewController })
                    .first else {
                return
            }
        calendarViewController.viewDidLoad()
        self.view?.navigationController?.popToViewController(calendarViewController, animated: true)
    }
}
