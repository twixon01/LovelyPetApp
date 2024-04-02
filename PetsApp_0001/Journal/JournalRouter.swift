//
//  JournalRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class JournalRouter: JournalRoutingLogic {
    weak var view: UIViewController?
    
    
    func routeToJournalAdd() {
        let vc = JournalAddAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: false)
    }

    func routeToJournalEdit(event: EventModel) {
        let vc = JournalEditAssembly.build(event: event)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
