//
//  JournalEditInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit
import Firebase

final class JournalEditInteractor: JournalEditBusinessLogic {
    // MARK: - Fields
    private let presenter: JournalEditPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: JournalEditPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadJournal(_ request: Model.Journal.Request) {
        presenter.presentJournal(Model.Journal.Response())
    }
    
    func addToDB (title: String, note : String, date : Date, dateEdit : Date) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        Firestore.firestore().collection("users_new").document(uid).collection("journal").document(stringFromDate(date)).setData(["Title": title, "Note": note, "Date": date, "DateEdit" : dateEdit]){ error in
            if let error = error {
                print("Ошибка при обновлении данных: \(error.localizedDescription)")
            } else {
                print("Поле успешно добавлено к документу")
            }
       

        }
    }
    
    func removeForDB (date: Date) {
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users_new").document(uid).collection("journal").document(stringFromDate(date)).delete()
        self.loadJournal(Model.Journal.Request())
        
    }
}

