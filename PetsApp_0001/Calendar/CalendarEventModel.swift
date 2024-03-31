//
//  CalendarEventModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

struct CalendarEventModel {
    var title: String
    var date: Date
    var notification: Date
    
    init(title: String, date: Date, notification: Date) {
        self.title = title
        self.date = date
        self.notification = notification
    }
}
