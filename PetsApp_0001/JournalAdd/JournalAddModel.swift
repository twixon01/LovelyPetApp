//
//  JournalAddModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

enum JournalAddModel {
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
    
    enum Journal {
        struct Request {
            var title: String?
            var text: String?
            var date: Date
            var dateEdit: Date
        }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
}

