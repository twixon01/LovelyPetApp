//
//  PetsRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class PetsRouter: PetsRoutingLogic {

    
    weak var view: UIViewController?
    
    func routeToPetAdd() {
        let vc = PetAddAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToPetPage(pet: PetModel) {
        let vc = PetPageAssembly.build(pet: pet)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
