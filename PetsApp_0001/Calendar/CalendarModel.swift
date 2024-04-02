//
//  CalendarModel.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

enum CalendarModel {
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
    
    enum CalendarAdd {
        struct Request { }
        struct Response { }
        struct ViewModel { }
        struct Info { }
    }
    
    enum CalendarEdit {
        struct Request { 
            var event: CalendarEventModel
        }
        struct Response { 
            var event: CalendarEventModel
        }
        struct ViewModel {
            var event: CalendarEventModel
        }
        struct Info {
            var event: CalendarEventModel
        }
    }
}

