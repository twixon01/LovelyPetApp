//
//  JournalEditViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit

final class JournalEditViewController: UIViewController,
                                       JournalEditDisplayLogic, UITextViewDelegate {
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    let event: EventModel
    
    private let textView: UITextView = UITextView()
    private let dateFormatter: DateFormatter = DateFormatter()
    private let alertDelete = UIAlertController(title: "Удаление заметки", message: "Вы собираетесь удалить заметку, подтвердите свое действие", preferredStyle: .alert)
    
    private let router: JournalEditRoutingLogic
    private let interactor: JournalEditBusinessLogic
    
    private var bottomConstraint: NSLayoutConstraint!
    
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
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .systemBackground
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.agreeDeleteTapped()
            
        }
        let cancelDeleteAction = UIAlertAction(title: "Отменить", style: .default)
        alertDelete.addAction(cancelDeleteAction)
        alertDelete.addAction(deleteAction)
        
        let tapKeyBoard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapKeyBoard)
        
        dateFormatter.locale = Locale.current
        let yearNote = Calendar.current.component(.year, from: event.dateEdit)
        let yearCurrent = Calendar.current.component(.year, from: Date())
        if yearNote < yearCurrent {
            dateFormatter.dateFormat = "d MMMM yyyy"
        } else {
            dateFormatter.dateFormat = "d MMMM HH:mm"
        }
        
        title = "\(dateFormatter.string(from: event.dateEdit))"
        
        if let navigationController = navigationController {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 12)
            ]
            navigationController.navigationBar.titleTextAttributes = attributes
        }
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        let deleteButton = UIBarButtonItem(title: "Удалить", style: .plain, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItems = [doneButton, deleteButton]
        
        deleteButton.isEnabled = true
        
        interactor.loadStart(Model.Start.Request())
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureTextView()
    }
    
    private func configureTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemBackground
        textView.font = UIFont.systemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        textView.textColor = .label
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.delegate = self
        textView.contentInsetAdjustmentBehavior = .automatic
        
        let fullText = "\(event.title ?? "")\n\(event.text ?? "")"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 0
        paragraphStyle.paragraphSpacing = 6
        let firstLineRange = (fullText as NSString).lineRange(for: NSRange(location: 0, length: 0))
        attributedString.addAttributes([
            .paragraphStyle: paragraphStyle,
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize + 6),
            .foregroundColor: UIColor.label
        ], range: firstLineRange)
        
        
        let otherLinesRange = NSRange(location: firstLineRange.upperBound, length: attributedString.length - firstLineRange.upperBound)
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: UIFont.labelFontSize - 1.3),
            .foregroundColor: UIColor.label
        ], range: otherLinesRange)
        
        textView.attributedText = attributedString
        
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomConstraint = textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if view.frame.height - textView.frame.maxY < (keyboardHeight + 34.58) {
            bottomConstraint.constant = -keyboardHeight-34.58
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let selectedRange = textView.selectedRange
        guard let text = textView.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 0
        paragraphStyle.paragraphSpacing = 6
        let attributesP: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize + 6),
            .foregroundColor: UIColor.label
        ]
        
        let attributesB: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: UIFont.labelFontSize-1.3),
            .foregroundColor: UIColor.label
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributesB)
        
        let firstLineRange = (text as NSString).lineRange(for: NSRange(location: 0, length: 0))
        attributedString.addAttributes(attributesP, range: firstLineRange)
        
        textView.attributedText = attributedString
        textView.selectedRange = selectedRange
        
    }
    
    
    @objc private func doneButtonTapped() {
        dismissKeyboard()
        let lines = textView.text.components(separatedBy: "\n")
        let firstLine = lines.first
        let note = lines.dropFirst().joined(separator: "\n")
        print(note)
        interactor.addToDB(title: firstLine!, note: note, date: event.date, dateEdit: Date())
        
    }
    
    @objc private func deleteButtonTapped() {
        self.present(alertDelete, animated: true)
    }
    
    @objc func agreeDeleteTapped() {
        interactor.removeForDB(date: event.date)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    
    func displayJournal(_ viewModel: Model.Journal.ViewModel) {
        router.routeToJournal()
    }
    
}
