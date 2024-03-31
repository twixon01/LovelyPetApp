//
//  CalendarAddViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

import UIKit

final class CalendarAddViewController: UIViewController,
                                       CalendarAddDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let router: CalendarAddRoutingLogic
    private let interactor: CalendarAddBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: CalendarAddRoutingLogic,
        interactor:CalendarAddBusinessLogic
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
        view.backgroundColor = .systemBackground
        let nameField: UITextField = UITextField()
        view.addSubview(nameField)
        
        nameField.setWidth(350)
        nameField.setHeight(35)
        nameField.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        nameField.pinCenterX(to: view)
        
        nameField.returnKeyType = .done
        nameField.textColor = .label
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
        configureUI()
    }
}
