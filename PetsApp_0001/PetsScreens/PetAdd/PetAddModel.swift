//
//  PetAddModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum PetAddModel {
    enum Start {
        struct Request { }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
    
    //    enum Other {
    //        struct Request { }
    //        struct Response { }
    //        struct ViewModel { }
    //        struct Info { }
    //    }
//    enum Pets {
//        struct Request { }
//            struct Response { }
//            struct ViewModel { }
//            struct Info { }
//        }
    
    enum Pets {
        struct Request {
            var name: String
            var type: String
            var breed: String
            var dateBirth: Date
            var date: Date
            var photo: UIImage?
            var color: String?
        }
            struct Response { }
            struct ViewModel { }
            struct Info { }
        }
}


