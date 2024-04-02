//
//  PetEditRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit

final class PetEditRouter: PetEditRoutingLogic {
    weak var view: UIViewController?
    
    func routeToPets() {
        guard let petsViewController = view?.navigationController?.viewControllers
                    .compactMap({ $0 as? PetsViewController })
                    .first else {
                return
            }
        
        petsViewController.configureCollection { Bool in
            if Bool == true {
                self.view?.navigationController?.popToViewController(petsViewController, animated: true)
            }
        }
          
    }
    
}
