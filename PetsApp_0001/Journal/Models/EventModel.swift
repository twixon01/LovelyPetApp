//
//  EventModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

struct EventModel {
    var title: String
    var description: String
    var petName: String
    var date: Date
    
    init(title: String, description: String, petName: String, date: Date) {
        self.title = title
        self.description = description
        self.petName = petName
        self.date = date
    }
}
