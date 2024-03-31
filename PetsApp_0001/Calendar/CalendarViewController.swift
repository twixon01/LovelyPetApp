//
//  CalendarViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class CalendarViewController: UIViewController,
                                    CalendarDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let label: UILabel = UILabel()
    private let addButton: UIButton = UIButton()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    #warning("TODO: eventsArray в интерактор")
    var eventArray: [CalendarEventModel] = [CalendarEventModel](repeating: CalendarEventModel(title: "title", date: Date.now, notification: Date.now.addingTimeInterval(-3600)), count: 5)
    
    private let router: CalendarRoutingLogic
    private let interactor: CalendarBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: CalendarRoutingLogic,
        interactor: CalendarBusinessLogic
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
        self.navigationItem.hidesBackButton = true
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureAddButton()
        configureLabel()
        configureCollection()
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        
        addButton.setWidth(50)
        addButton.setHeight(50)
        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        addButton.pinRight(to: view.trailingAnchor, 10)
        
        if let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)) {
            let largerImage = image.withRenderingMode(.alwaysOriginal)
            addButton.setImage(largerImage, for: .normal)
        }
        
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    private func configureLabel() {
        view.addSubview(label)
        
        label.text = "calendar".localized
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        label.pinLeft(to: view.leadingAnchor, 10)
        label.pinCenterY(to: addButton.centerYAnchor)
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
        
        collectionView.register(CalendarEventCell.self, forCellWithReuseIdentifier: "calendar event")
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: label.bottomAnchor, 10)
    }
    
    // MARK: - Actions
    @objc
    private func addTapped() {
        interactor.loadCalendarAdd(CalendarModel.CalendarAdd.Request())
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
        
    }
    func displayCalendarAdd(_ viewModel: Model.CalendarAdd.ViewModel) {
        router.routeToCalendarAdd()
        
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarEventCell.reuseId, for: indexPath)
        
        guard let calendarEventCell = cell as? CalendarEventCell else {
            return cell
        }
        
        let event = eventArray[indexPath.row]
        calendarEventCell.configure(with: event)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Cell tapped at index \(indexPath.item)")
        }
}