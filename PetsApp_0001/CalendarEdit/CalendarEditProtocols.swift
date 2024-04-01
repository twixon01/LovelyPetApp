//
//  CalendarEditProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

protocol CalendarEditBusinessLogic {
    typealias Model = CalendarEditModel
    func loadStart(_ request: Model.Start.Request)
    // func load(_ request: Model..Request)
}

protocol CalendarEditPresentationLogic {
    typealias Model = CalendarEditModel
    func presentStart(_ response: Model.Start.Response)
    // func present(_ response: Model..Response)
}

protocol CalendarEditDisplayLogic: AnyObject {
    typealias Model = CalendarEditModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol CalendarEditAnalitics: AnyObject {
    typealias Model = CalendarEditModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol CalendarEditRoutingLogic {
    func routeTo()
}

