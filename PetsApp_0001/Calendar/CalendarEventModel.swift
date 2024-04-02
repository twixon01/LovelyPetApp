//
//  CalendarEventModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

struct CalendarEventModel {
    var title: String?
    var date: Date
    var notification1: Date
    var notification2: Date
    var dateEdit: Date
    
    init(title: String, date: Date, notification1: Date, notification2: Date, dateEdit: Date) {
        self.title = title
        self.date = date
        self.notification1 = notification1
        self.notification2 = notification2
        self.dateEdit = dateEdit
    }
}
