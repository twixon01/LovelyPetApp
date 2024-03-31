//
//  RegistrationRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class RegistrationRouter: RegistrationRoutingLogic {
    weak var view: UIViewController?
    
    func routeToJournal() {
        let vc = JournalAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
