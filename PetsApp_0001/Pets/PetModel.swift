//
//  PetModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

struct PetModel {
    var name: String
    var image: UIImage?
    var breed: String?
    var type: String?
    var birthday: Date?
    var color: String?
    var lastVactination: String?
    var yearVactination: String?
    var birth: Date?
    var lastBath: String?
    var date: String?
    
    init(name: String) {
        self.name = name
        image = UIImage(named: "no_photo")
    }
    
    init(name: String, image: UIImage, breed: String, type: String, color: String, lastVactination: String, yearVactination: String, birth: Date, lastBath: String, date: String) {
        self.name = name
        self.image = image
        self.breed = breed
        self.type = type
        self.color = color
        self.lastVactination = lastVactination
        self.yearVactination = yearVactination
        self.birth = birth
        self.lastBath = lastBath
        self.date = date
    }
    
    init(name: String, image: UIImage, birthday: Date) {
        self.name = name
        self.image = image
        self.birthday = birthday
        
    }
}
