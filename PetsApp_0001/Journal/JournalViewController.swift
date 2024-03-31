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
    }
    // MARK: - Fields
    private let addButton: UIButton = UIButton()
    private let label: UILabel = UILabel()
    private let table: UIScrollView = UIScrollView(frame: UIScreen.main.bounds)
    
#warning("TODO: events в интерактор")
    private let events: [EventModel] = [EventModel](repeating: EventModel(title: "event", description: "description", petName: "pet", date: Date.now), count: 15)
    
    var sumH: CGFloat = 120.0
    
    private let router: JournalRoutingLogic
    private let interactor: JournalBusinessLogic
    private var presenter: JournalPresenter
    
    
    // MARK: - LifeCycle
    init(
        router: JournalRoutingLogic,
        interactor: JournalBusinessLogic,
        presenter: JournalPresenter
    ) {
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
//        let currId = (Auth.auth().currentUser?.uid)!
//        let collectionns = Firestore.firestore().collection("users_new").document(currId).collection("journal")
//        collectionns.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Ошибка получения документов: \(error.localizedDescription)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let data = document.data() // Получаем данные документа
//                    if !data.isEmpty{
//                        print(data["Title"], data["Note"])
//                    }
//                }
//                
//            
//            }
//        }
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureTable()
        configureAddButton()
        configureLabel()
    }
    
    private func configureAddButton() {
        table.addSubview(addButton)
        
        addButton.setWidth(50)
        addButton.setHeight(50)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: table.topAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: table.trailingAnchor, constant: 425).isActive = true
        
        if let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)) {
            let largerImage = image.withRenderingMode(.alwaysOriginal)
            addButton.setImage(largerImage, for: .normal)
        }
        
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    private func configureLabel() {
        table.addSubview(label)
        
        label.text = "journal".localized
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        label.pinCenterY(to: addButton.centerYAnchor)
    }
    
    private func configureTable() {
        table.isScrollEnabled = true
        table.isPagingEnabled = false
        table.showsVerticalScrollIndicator = true
        table.backgroundColor = .clear
        
        view.addSubview(table)
        
        var yOffset: CGFloat = 50
        let spacing: CGFloat = 20
        
        for i in events {
            let h: CGFloat = UIScreen.main.bounds.width / 5
            let size = CGSize(width: UIScreen.main.bounds.width - 20, height: h)
            let page = createCellPage(size: size, model: i)
            page.frame.origin.y = yOffset
            table.addSubview(page)
            yOffset += h + spacing
        }
        
        table.contentSize = CGSize(width: UIScreen.main.bounds.width - 20, height: yOffset - spacing)
    }
    
    func createCellPage(size: CGSize, radius: CGFloat = 20, model: EventModel) -> UIView {
        let aFrame = CGRect(x: 10, y: 0, width: size.width, height: size.height)
        let aPage = EventCell(frame: aFrame)
        aPage.configure(with: model)
        aPage.layer.cornerRadius = radius
        aPage.layer.masksToBounds = true
        aPage.backgroundColor = .green
        
        return aPage
    }
    
    // MARK: - Actions
    @objc
    private func addTapped() {
        interactor.loadJournalAdd(JournalModel.JournalAdd.Request())
        
    }
    
    @objc
    func calendarTapped() {
        interactor.loadCalendar(JournalModel.Calendar.Request())
    }
    
    //    @objc
    //    func journalTapped() {
    //        return
    //    }
    
    @objc
    func petsTapped() {
        interactor.loadPets(JournalModel.Pets.Request())
    }
    
    @objc
    func settingsTapped() {
        interactor.loadSettings(JournalModel.Settings.Request())
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


