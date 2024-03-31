//
//  JournalAddInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import Firebase

final class JournalAddInteractor: JournalAddBusinessLogic {
    // MARK: - Fields
    private let presenter: JournalAddPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: JournalAddPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func addToDB (title: String, note : String, date : String) {
        let uid = Auth.auth().currentUser?.uid ?? ""

        Firestore.firestore().collection("users_new").document(uid).collection("journal").document(date).setData(["Title": title, "Note": note]){ error in
            if let error = error {
                print("Ошибка при обновлении данных: \(error.localizedDescription)")
            } else {
                print("Поле успешно добавлено к документу")
            }
       

        }
       
    }
    
    func loadJournal(_ request: Model.Journal.Request) {
        presenter.presentJournal(Model.Journal.Response())
    }
}

