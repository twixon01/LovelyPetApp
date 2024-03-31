//
//  AuthRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class AuthRouter: AuthRoutingLogic {
    weak var view: UIViewController?
    
    func routeToAccessRecovery() {
        let vc = AccessRecoveryAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToRegistration() {
        let vc = RegistrationAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: false)
    }
    
    func routeToJournal() {
        let vc = TabBarController()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
