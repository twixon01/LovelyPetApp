//
//  CalendarAddInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

import UIKit
import Firebase

final class CalendarAddInteractor: CalendarAddBusinessLogic {
    
    
    // MARK: - Fields
    private let presenter: CalendarAddPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CalendarAddPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadCalendar(_ request: Model.Calendar.Request) {
        presenter.presentCalendar(Model.Calendar.Response())
    }
    
    func addToDB (title: String, date : Date, notify1: Date, notify2: Date, currentDate: Date) {
        func stringFromDateNot(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.dateFormat = "d MMMM HH:mm"
            return dateFormatter.string(from: date)
        }
        self.scheduleNotification(date: notify1, body: "\(title) состоится \(stringFromDateNot(date))", identifier: "firstNotify")
        self.scheduleNotification(date: notify2, body: "\(title) состоится \(stringFromDateNot(date))", identifier: "secondNotify")
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatter.string(from: date)
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users_new").document(uid).collection("calendar").document(stringFromDate(date)).setData(["Title": title, "Date": date, "Notify1": notify1, "Notify2": notify2, "DateEdit": currentDate]){ error in
            if let error = error {
                print("Ошибка при обновлении данных: \(error.localizedDescription)")
                
            } else {
                print("Поле успешно добавлено к документу")
                self.loadCalendar(Model.Calendar.Request())
            }
        }
        
    }
    
    func scheduleNotification(date: Date, body: String, identifier: String) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Питомцы не ждут!"
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление добавлено")
            }
        }
    }

}
