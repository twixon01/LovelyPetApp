//
//  CalendarProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

protocol CalendarBusinessLogic {
    typealias Model = CalendarModel
    func loadStart(_ request: Model.Start.Request)
    func loadCalendarAdd(_ request: Model.CalendarAdd.Request)
    func loadCalendarEdit(_ request: Model.CalendarEdit.Request)
    func configureCollection(completion: @escaping ([CalendarEventModel]) -> Void)
    // func load(_ request: Model..Request)
}

protocol CalendarPresentationLogic {
    typealias Model = CalendarModel
    func presentStart(_ response: Model.Start.Response)
    func presentCalendarAdd(_ response: Model.CalendarAdd.Response)
    func presentCalendarEdit(_ response: Model.CalendarEdit.Response)
    // func present(_ response: Model..Response)
}

protocol CalendarDisplayLogic: AnyObject {
    typealias Model = CalendarModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayCalendarAdd(_ viewModel: Model.CalendarAdd.ViewModel)
    func displayCalendarEdit(_ viewModel: Model.CalendarEdit.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol CalendarAnalitics: AnyObject {
    typealias Model = CalendarModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol CalendarRoutingLogic {
    typealias Model = CalendarModel
    func routeTo()
    func routeToCalendarAdd()
    func routeToCalendarEdit(event: CalendarEventModel)
}
