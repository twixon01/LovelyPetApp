//
//  CalendarEditViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

import UIKit

final class CalendarEditViewController: UIViewController,
                                        CalendarEditDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let router: CalendarEditRoutingLogic
    private let interactor: CalendarEditBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: CalendarEditRoutingLogic,
        interactor: CalendarEditBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        
    }
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        
    }
}
