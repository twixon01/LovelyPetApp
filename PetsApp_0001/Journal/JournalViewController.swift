//
//  JournalViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

public final class JournalViewController: UIViewController,
                                          JournalDisplayLogic {

    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
        static let eventCellIdentifier = "EventCell"
    }

    // MARK: - Fields
    private let addButton: UIButton = UIButton()
    private let tableView: UITableView = UITableView()
    private let label: UILabel = UILabel()

    private let router: JournalRoutingLogic
    private let interactor: JournalBusinessLogic
    private var presenter: JournalPresenter

    private let events: [EventModel] = [EventModel](repeating: EventModel(title: "event", description: "description", petName: "pet", date: Date.now), count: 15)

    // MARK: - LifeCycle
    init(router: JournalRoutingLogic, interactor: JournalBusinessLogic, presenter: JournalPresenter) {
        self.router = router
        self.interactor = interactor
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.viewController = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground

        interactor.loadStart(Model.Start.Request())
    }

    // MARK: - Configuration
    private func configureUI() {
        configureAddButton()
        configureLabel()
       
       
    }

    private func configureAddButton() {
        addButton.tintColor = .systemPink
        view.addSubview(addButton)
        
        addButton.setWidth(30)
        addButton.setHeight(30)
        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        addButton.pinRight(to: view.trailingAnchor, 15)
        
        if let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)) {
            let largerImage = image.withRenderingMode(.alwaysTemplate)
            addButton.setImage(largerImage, for: .normal)
        }
       
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }

    private func configureLabel() {
        view.addSubview(label)
        label.text = "journal".localized
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        label.textColor = UIColor.label
        label.pinCenterY(to: addButton.centerYAnchor)
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
    }

    // MARK: - Actions
    @objc
    private func addTapped() {
        interactor.loadJournalAdd(JournalModel.JournalAdd.Request())
    }

    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
       configureUI()
    }

    func displaySettings(_ viewModel: Model.Settings.ViewModel) {
        router.routeToSettings()
    }

    func displayPets(_ viewModel: Model.Pets.ViewModel) {
        router.routeToPets()
    }

    func displayCalendar(_ viewModel: Model.Calendar.ViewModel) {
        router.routeToCalendar()
    }

    func displayJournalAdd(_ viewModel: Model.JournalAdd.ViewModel) {
        router.routeToJournalAdd()
    }
}


