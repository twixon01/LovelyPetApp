//
//  JournalViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

final class JournalViewController: UIViewController,
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
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var events: [EventModel] = []

    private let router: JournalRoutingLogic
    private let interactor: JournalBusinessLogic
    private var presenter: JournalPresenter



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
        interactor.configureCollection { [weak self] events in
            guard let self = self else { return }
            self.events = events
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.configureCollection()
            }
            self.interactor.loadStart(Model.Start.Request())
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.configureCollection { [weak self] events in
            guard let self = self else { return }
            self.events = events
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.configureCollection()
            }
            self.interactor.loadStart(Model.Start.Request())
        }
    }


    // MARK: - Configuration
    private func configureUI() {
        configureAddButton()
        configureLabel()
        configureCollection()
       
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
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 2.5
            layout.invalidateLayout()
        }
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "event")
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.pinHorizontal(to: view,5)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: label.bottomAnchor, 15)
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


    func displayJournalAdd(_ viewModel: Model.JournalAdd.ViewModel) {
        router.routeToJournalAdd()
    }
    
    func displayJournalEdit(_ viewModel: Model.JournalEdit.ViewModel) {
        router.routeToJournalEdit(event: viewModel.event)
    }
}

extension JournalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.reuseId, for: indexPath)
        
        guard let eventCell = cell as? EventCollectionViewCell else {
            return cell
        }
        
        let event = events[indexPath.row]
        eventCell.configure(with: event)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width - 10, height: 57)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            interactor.loadJournalEdit(JournalModel.JournalEdit.Request(event: events[indexPath.row]))
            print("Cell tapped at index \(indexPath.item)")
        }
}
