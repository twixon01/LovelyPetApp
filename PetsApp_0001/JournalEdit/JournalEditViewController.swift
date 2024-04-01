//
//  JournalEditViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit

final class JournalEditViewController: UIViewController,
                                       JournalEditDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    let event: EventModel
    
    private let router: JournalEditRoutingLogic
    private let interactor: JournalEditBusinessLogic
    
    // MARK: - LifeCycle
    init(
        event: EventModel,
        router: JournalEditRoutingLogic,
        interactor: JournalEditBusinessLogic
    ) {
        self.event = event
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
        view.backgroundColor = UIColor.systemBackground
        print(event.title)
    }
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
}
