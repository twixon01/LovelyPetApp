//
//  JournalInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import Firebase
import UIKit

final class JournalInteractor: JournalBusinessLogic {

    
    // MARK: - Fields
    private let presenter: JournalPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: JournalPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    
    func loadJournalAdd(_ request: Model.JournalAdd.Request) {
        presenter.presentJournalAdd(Model.JournalAdd.Response())
    }
    
    func loadJournalEdit(_ request: Model.JournalEdit.Request) {
        presenter.presentJournalEdit(Model.JournalEdit.Response(event: request.event))
    }
    
    func configureCollection(completion: @escaping ([EventModel]) -> Void) {
        var eventsArray: [EventModel] = []
        
        let currId = (Auth.auth().currentUser?.uid)!
        let collectionns = Firestore.firestore().collection("users_new").document(currId).collection("journal")
        collectionns.order(by: "Date", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка получения документов: \(error.localizedDescription)")
                completion(eventsArray)
            } else {
                var eventModels: [EventModel] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if !data.isEmpty {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale.current
                        dateFormatter.dateFormat = "d MMMM yyyy"
                        let title = data["Title"] as! String
                        let date = data["Date"] as! Timestamp
                        let dateEdit = data["DateEdit"] as! Timestamp
                        let note = data["Note"] as! String
                        
                        let eventModel = EventModel(title: title, text: note, date: date.dateValue(), dateEdit: dateEdit.dateValue())
                        eventModels.append(eventModel)
                        
                    }
                }
                eventsArray = eventModels.sorted { (eventModel1: EventModel, eventModel2: EventModel) -> Bool in
                    return eventModel1.dateEdit > eventModel2.dateEdit
                }
                    completion(eventsArray)
                }
            }
        }
}

