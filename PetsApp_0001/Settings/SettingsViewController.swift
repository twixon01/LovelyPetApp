//
//  SettingsViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit
import Firebase

public final class SettingsViewController: UIViewController,
                                           SettingsDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let label: UILabel = UILabel()
    private let logOutButton: UIButton = UIButton()
    private let alert: UIAlertController = UIAlertController(title: "log_out_alert".localized, message: nil, preferredStyle: UIAlertController.Style.alert)
    
    private let tableView: UITableView = UITableView(frame: .zero)
    let cellIdentifier = "SettingsCell"
    
    private let router: SettingsRoutingLogic
    private let interactor: SettingsBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: SettingsRoutingLogic,
        interactor: SettingsBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let cancelAction = UIAlertAction(title: "no".localized, style: .default)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "yes".localized, style: .destructive){ _ in
            self.okWasTapped()
        }
        alert.addAction(okAction)
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureLogOutButton()
        configureLabel()
        configureTable()
    }
    
    private func configureLabel() {
        view.addSubview(label)
        self.label.text = "settings".localized
        self.label.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
    }
    
    private func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        tableView.backgroundColor = UIColor.systemBackground
        tableView.separatorStyle = .none
        tableView.pinTop(to: label.bottomAnchor, 20)
        tableView.pinHorizontal(to: view, 15)
        tableView.pinBottom(to: logOutButton.topAnchor, 10)
    }
    
    private func configureLogOutButton() {
        view.addSubview(logOutButton)
        
        
        logOutButton.setTitle("log_out".localized, for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.backgroundColor = .systemRed
        logOutButton.layer.cornerRadius = 7
        logOutButton.pinTop(to: view.safeAreaLayoutGuide.bottomAnchor, -70)
        logOutButton.pinCenterX(to: view)
        logOutButton.setWidth(350)
        logOutButton.setHeight(35)
        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    @objc private func logOut() {
        UIView.animate(withDuration: 0.1, animations: {
            self.logOutButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.logOutButton.transform = .identity
            }
        }
        self.present(alert, animated: true)
    }
    
    private func okWasTapped(){
        interactor.loadAuth(SettingsModel.AuthMy.Request())
        do
        {
            try  Auth.auth().signOut()
        }catch{
            print(error)
        }
    }
    
    @objc
    func journalTapped() {
        interactor.loadJournal(SettingsModel.Journal.Request())
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayAuth(_ viewModel: Model.AuthMy.ViewModel) {
        router.routeToAuth()
    }
    
    func displayJournal(_ viewModel: Model.Journal.ViewModel) {
        router.routeToJournal()
    }
}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.backgroundColor = .cellBackground
        cell.layer.cornerRadius = 12
        cell.textLabel?.text = "Аккаунт"
        cell.imageView?.image = UIImage(systemName: "person.fill")
        cell.accessoryType = .disclosureIndicator
        
        
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
    }
}
