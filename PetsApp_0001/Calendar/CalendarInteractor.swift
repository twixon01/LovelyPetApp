//
//  CalendarInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit
import Firebase

final class CalendarInteractor: CalendarBusinessLogic {
    
    
    // MARK: - Fields
    private let presenter: CalendarPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadCalendarAdd(_ request: Model.CalendarAdd.Request) {
        presenter.presentCalendarAdd(Model.CalendarAdd.Response())
    }
    
    func configureCollection(completion: @escaping ([CalendarEventModel]) -> Void) {
        var eventsArray: [CalendarEventModel] = []
        
        let currId = (Auth.auth().currentUser?.uid)!
        let collectionns = Firestore.firestore().collection("users_new").document(currId).collection("calendar")
        collectionns.order(by: "Date", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка получения документов: \(error.localizedDescription)")
                completion(eventsArray)
            } else {
                var eventModels: [CalendarEventModel] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if !data.isEmpty {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale.current
                        dateFormatter.dateFormat = "d MMMM yyyy"
                        let title = data["Title"] as! String
                        let date = data["Date"] as! Timestamp
                        let notify1 = data["Notify1"] as! Timestamp
                        let notify2 = data["Notify2"] as! Timestamp
                        let dateEdit = data["DateEdit"] as! Timestamp
                        let eventModel = CalendarEventModel(title: title, date: date.dateValue(), notification1: notify1.dateValue(), notification2: notify2.dateValue(), dateEdit: dateEdit.dateValue())
                        eventModels.append(eventModel)
                    }
                }
                eventsArray = eventModels
                completion(eventsArray)
            }
        }
    }
    
}
