//
//  CalendarAddProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 15.03.2024.
//

import UIKit

protocol CalendarAddBusinessLogic {
    typealias Model = CalendarAddModel
    func loadStart(_ request: Model.Start.Request)
    func loadCalendar(_ request: Model.Calendar.Request)
    func addToDB (title: String, date : Date, notify1: Date, notify2: Date, currentDate: Date)
    // func load(_ request: Model..Request)
}

protocol CalendarAddPresentationLogic {
    typealias Model = CalendarAddModel
    func presentStart(_ response: Model.Start.Response)
    func presentCalendar(_ response: Model.Calendar.Response)
    // func present(_ response: Model..Response)
}

protocol CalendarAddDisplayLogic: AnyObject {
    typealias Model = CalendarAddModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayCalendar(_ viewModel: Model.Calendar.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol CalendarAddAnalitics: AnyObject {
    typealias Model = CalendarAddModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol CalendarAddRoutingLogic {
    func routeToCalendar()
}

