//
//  JournalEditRouter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit

final class JournalEditRouter: JournalEditRoutingLogic {
    weak var view: UIViewController?
    
    func routeToJournal() {
        guard let journalViewController = view?.navigationController?.viewControllers
                    .compactMap({ $0 as? JournalViewController })
                    .first else {
                return
            }
        self.view?.navigationController?.popToViewController(journalViewController, animated: true)
    }
}
