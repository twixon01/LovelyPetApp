//
//  AccessRecoveryRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class AccessRecoveryRouter: AccessRecoveryRoutingLogic {
    
    weak var view: UIViewController?
    
    func routeToResetPassword() {
        view?.navigationController?.popViewController(animated: true)
    }
}
