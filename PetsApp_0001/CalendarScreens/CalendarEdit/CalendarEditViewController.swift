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
    let event: CalendarEventModel
    private let titleField: UITextField = UITextField()
    private let dateLabel: UILabel = UILabel()
    private let datePicker = UIDatePicker()
    private let notifyLabel: UILabel = UILabel()
    private let notifyDatePicker = UIDatePicker()
    private let notifyLabel2: UILabel = UILabel()
    private let notifyDatePicker2 = UIDatePicker()
    private let alertDelete = UIAlertController(title: "Удаление события", message: "Вы собираетесь удалить событие, подтвердите свое действие", preferredStyle: .alert)
    
    private let router: CalendarEditRoutingLogic
    private let interactor: CalendarEditBusinessLogic
    
    // MARK: - LifeCycle
    init(
        event: CalendarEventModel,
        router: CalendarEditRoutingLogic,
        interactor: CalendarEditBusinessLogic
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
        view.backgroundColor = .systemBackground
        let tapKeyBoard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapKeyBoard)
        let deleteAction = UIAlertAction(title: "delete".localized, style: .destructive) { _ in
            self.agreeDeleteTapped()
            
        }
        let cancelDeleteAction = UIAlertAction(title: "cancelB".localized, style: .default)
        alertDelete.addAction(cancelDeleteAction)
        alertDelete.addAction(deleteAction)
       
        let doneButton = UIBarButtonItem(title: "save".localized, style: .done, target: self, action: #selector(doneButtonTapped))
        let deleteButton = UIBarButtonItem(title: "delete_event".localized, style: .plain, target: self, action:
                                            #selector(deleteWasTapped))
        deleteButton.tintColor = .red
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItems = [doneButton, deleteButton]
        
        deleteButton.isEnabled = true
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureTitle()
        configureDateLabel()
        configureDatePicker()
        configureNotifyLabel()
        configureNotifyDatePicker()
        configureNotifyLabel2()
        configureNotifyDatePicker2()
        

    }
    
    private func configureTitle() {
        view.addSubview(titleField)
        
        titleField.placeholder = "event".localized
        titleField.text = event.title
        titleField.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        titleField.textColor = UIColor.label
        NSLayoutConstraint.activate([
            titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
               titleField.heightAnchor.constraint(equalToConstant: 50)
           ])
        
        
        titleField.pinTop(to: view.safeAreaLayoutGuide.topAnchor,12)
        titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureDateLabel() {
        view.addSubview(dateLabel)
        
        dateLabel.text = "\("date".localized):"
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        dateLabel.pinTop(to: titleField.bottomAnchor, 25)
        dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21).isActive = true
        dateLabel.textColor = .label
    }
    
    private func configureDatePicker() {
        view.addSubview(datePicker)
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = true
        datePicker.date = event.date
        datePicker.minimumDate = Date()
        datePicker.pinLeft(to: dateLabel.trailingAnchor, 5)
        datePicker.pinCenterY(to: dateLabel.centerYAnchor)
        
    }
    
    private func configureNotifyLabel() {
        view.addSubview(notifyLabel)
        
        notifyLabel.text = "\("alert_not1".localized):"
        notifyLabel.font = UIFont.systemFont(ofSize: 17)
        notifyLabel.pinTop(to: dateLabel.bottomAnchor, 25)
        notifyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21).isActive = true
        notifyLabel.textColor = .label
    }
    
    private func configureNotifyDatePicker() {
        view.addSubview(notifyDatePicker)
        
        notifyDatePicker.datePickerMode = .dateAndTime
        notifyDatePicker.date = event.notification1
        notifyDatePicker.minimumDate = Date()
        notifyDatePicker.translatesAutoresizingMaskIntoConstraints = true
        notifyDatePicker.pinLeft(to: notifyLabel.trailingAnchor, 5)
        notifyDatePicker.pinCenterY(to: notifyLabel.centerYAnchor)
        
    }
    
    private func configureNotifyLabel2() {
        view.addSubview(notifyLabel2)
        
        notifyLabel2.text = "\("alert_not2".localized):"
        notifyLabel2.font = UIFont.systemFont(ofSize: 16)
        notifyLabel2.pinTop(to: notifyLabel.bottomAnchor, 25)
        notifyLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21).isActive = true
        notifyLabel.textColor = .label
    }
    
    private func configureNotifyDatePicker2() {
        view.addSubview(notifyDatePicker2)
        
        notifyDatePicker2.datePickerMode = .dateAndTime
        notifyDatePicker2.translatesAutoresizingMaskIntoConstraints = true
        notifyDatePicker2.date = event.notification2
        notifyDatePicker2.minimumDate = Date()
        notifyDatePicker2.pinLeft(to: notifyLabel2.trailingAnchor, 5)
        notifyDatePicker2.pinCenterY(to: notifyLabel2.centerYAnchor)
        
    }
    
    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
    @objc func doneButtonTapped() {
        interactor.addToDB(title: titleField.text!, date : datePicker.date, notify1: notifyDatePicker.date, notify2: notifyDatePicker2.date, currentDate: event.dateEdit)
    }
    
    @objc func deleteWasTapped() {
            self.present(alertDelete, animated: true)
        
    }
    
    @objc func agreeDeleteTapped() {
        interactor.removeForDB(dateEdit: event.dateEdit)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayCalendar(_ viewModel: Model.Calendar.ViewModel) {
        router.routeToCalendar()
    }
}
