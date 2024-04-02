//
//  EventModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

struct EventModel {
    var title: String?
    var text: String?
    var date: Date
    var dateEdit: Date
    
    init(title: String, date: Date, dateEdit: Date) {
        self.title = title
        self.date = date
        self.dateEdit = dateEdit
    }
    
    init(text: String, date: Date, dateEdit: Date) {
        self.text = title
        self.date = date
        self.dateEdit = dateEdit
    }
    
    init(date: Date, dateEdit: Date) {
        self.dateEdit = dateEdit
        self.date = date
    }
    
    init(title: String, text: String, date: Date, dateEdit: Date) {
        self.title = title
        self.text = text
        self.date = date
        self.dateEdit = dateEdit
    }
}
