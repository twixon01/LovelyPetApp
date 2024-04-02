//
//  UserModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 02.04.2024.
//

import UIKit

struct UserModel {
    var name: String?
    var email: String?
   
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    init() {
       
    }
    
}

