//
//  PetsModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum PetsModel {
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
    
    enum PetAdd {
        struct Request { }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
    
    enum PetPage {
        struct Request { }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
    
    enum Pets {
        struct Request {
            var pet: PetModel
        }
        struct Response {
            var pet: PetModel
        }
        struct ViewModel {
            var pet: PetModel
        }
        struct Info { }
    }
}


