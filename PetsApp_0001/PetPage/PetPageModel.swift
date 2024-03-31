//
//  PetPageModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit

enum PetPageModel {
    enum Start {
        struct Request { }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
    enum PetEdit {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
        }
        struct Info { }
    }
    
    //    enum Other {
    //        struct Request { }
    //        struct Response { }
    //        struct ViewModel { }
    //        struct Info { }
    //    }
    
    enum Pets {
        struct Request { var pet: PetModel }
        struct Response { var pet: PetModel }
        struct ViewModel { var pet: PetModel }
        struct Info {var pet: PetModel }
    }
    
    
}
