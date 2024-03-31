//
//  JournalAddViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

final class JournalAddViewController: UIViewController, JournalAddDisplayLogic, UITextViewDelegate {
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let router: JournalAddRoutingLogic
    private let interactor: JournalAddBusinessLogic
    
    
//    private let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneButtonTapped))
////    
//    private let backImage = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
//    
//    private let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
//        return formatter
//    }()
//    
//    private var formattedDate: String = ""
  
    
    
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
//        formattedDate = dateFormatter.string(from: Date())
//        let formattedDate = dateFormatter.string(from: Date())
//        interactor.addToDB(title: "fist", note: "first", date: formattedDate)
//        textView.delegate = self
//       
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//        self.navigationController?.navigationBar.backItem?.title = "Назад"
//        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.isEnabled = true
//        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture(_:)))
//                edgePanGesture.edges = .left
//                view.addGestureRecognizer(edgePanGesture)
//        
        interactor.loadStart(Model.Start.Request())
        
        
       
    }
    
    // MARK: - Configuration
    private func configureUI() {
//        configureTextViews()
    }
    
//    private func configureTextViews() {
//        
//    
//
//
//
//
//       
//
//
//        view.addSubview(textView)
//
//        NSLayoutConstraint.activate([
//            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
//            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            
//    
//        ])
//        view.clipsToBounds = true
//      
//        
//        navigationItem.rightBarButtonItem = doneButton
//    }

    // MARK: - Actions
    @objc
    private func wasTapped() {
        
    }
    
//    @objc func doneButtonTapped() {
//        interactor.addToDB(title: textView.text!, note: noteTextView.text!, date: formattedDate)
//        noteTextView.resignFirstResponder()
//    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
//    func textViewDidChange(_ textView: UITextView) {
//
//            guard let text = textView.text else {
//                return
//            }
//
//            
//            let lines = text.components(separatedBy: "\n")
//     
//        let attributedString = NSMutableAttributedString(string: text)
//        let range = NSRange(location: 0, length: text.count)
//        attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: range)
//        let firstLine = lines.first ?? ""
//        let currentLine = lines.last
//            print("here")
//        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: firstLine.count))
//            print(firstLine.count)
//       
//            
//        textView.attributedText = attributedString
//        
//
//           
//        }
    func displayJournal(_ viewModel: Model.Journal.ViewModel) {
        router.routeToJournal()
    }
}
    
