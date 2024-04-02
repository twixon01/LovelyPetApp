//
//  CalendarRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class CalendarRouter: CalendarRoutingLogic {
    weak var view: UIViewController?
    
    func routeTo() {
        
    }
    
    func routeToCalendarAdd() {
        let vc = CalendarAddAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToCalendarEdit(event: CalendarEventModel) {
        let vc = CalendarEditAssembly.build(event: event)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
