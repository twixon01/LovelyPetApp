//
//  SettingsRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class SettingsRouter: SettingsRoutingLogic {
    weak var view: UIViewController?
    
    func routeToAuth() {
        let vc = AuthAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToAccountSettings() {
        let vc = AccountSettingsAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
