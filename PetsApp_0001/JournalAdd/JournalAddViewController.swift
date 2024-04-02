//
//  JournalAddViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class JournalAddViewController: UIViewController,
                                      JournalAddDisplayLogic, UITextViewDelegate {
    
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    
    private let textView: UITextView = UITextView()
    private let dateFormatter: DateFormatter = DateFormatter()
    private let currentDate: Date = Date()
    
    private let router: JournalAddRoutingLogic
    private let interactor: JournalAddBusinessLogic
    
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - LifeCycle
    init(
        router: JournalAddRoutingLogic,
        interactor: JournalAddBusinessLogic
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
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .systemBackground
        
        let tapKeyBoard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapKeyBoard)
        
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMMM HH:mm"
        title = "\(dateFormatter.string(from: currentDate))"
        
        if let navigationController = navigationController {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 12)
            ]
            navigationController.navigationBar.titleTextAttributes = attributes
        }
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        
        doneButton.isEnabled = true
        navigationItem.rightBarButtonItem = doneButton
        
        textView.becomeFirstResponder()
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
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomConstraint = textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func keyboardWillShow(_ notification: Notification) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.hidesBackButton = true
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
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationItem.hidesBackButton = false
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
        paragraphStyle.paragraphSpacing = 7
        let attributesP: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(name: "CenturyGothic-Bold", size: 24.0) ?? UIFont.boldSystemFont(ofSize: UIFont.labelFontSize + 6),
            .foregroundColor: UIColor.label
        ]
        
        let attributesB: [NSAttributedString.Key: Any] = [
            .font:UIFont(name: "CenturyGothic", size: 14.5) ?? UIFont.boldSystemFont(ofSize: UIFont.labelFontSize - 1.3),
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
        interactor.addToDB(title: firstLine!, note: note, date: currentDate, dateEdit: currentDate)
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
    }
}
