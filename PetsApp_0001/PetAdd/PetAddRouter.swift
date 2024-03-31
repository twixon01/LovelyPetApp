//
//  PetAddRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class PetAddRouter: PetAddRoutingLogic {
    weak var view: UIViewController?
    
    func routeTo() {
        
    }
    
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
