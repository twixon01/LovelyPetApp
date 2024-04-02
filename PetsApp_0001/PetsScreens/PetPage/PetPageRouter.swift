//
//  PetPageRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit

final class PetPageRouter: PetPageRoutingLogic {
    weak var view: UIViewController?
    
    func routeToPetEdit(pet: PetModel) {
        let vc = PetEditAssembly.build(pet: pet)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
