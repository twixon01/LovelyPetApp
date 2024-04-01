//
//  EventModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

struct EventModel {
    var title: String
    var text: String?
    var date: Date
    
    init(title: String, date: Date) {
        self.title = title
        self.date = date
    }
    
    init(title: String, text: String, date: Date) {
        self.title = title
        self.text = text
        self.date = date
    }
}
