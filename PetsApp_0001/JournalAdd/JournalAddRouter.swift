//
//  JournalAddRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class JournalAddRouter: JournalAddRoutingLogic {
    weak var view: UIViewController?
    
    func routeTo() {
        
    }
    
    func routeToJournal() {
        let vc = JournalAssembly.build()
        view?.navigationController?.pushViewController(vc, animated: false)
    }
}
