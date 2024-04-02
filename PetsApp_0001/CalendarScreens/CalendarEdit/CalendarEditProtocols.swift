//
//  CalendarEditProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 27.03.2024.
//

import UIKit

protocol CalendarEditBusinessLogic {
    typealias Model = CalendarEditModel
    func loadStart(_ request: Model.Start.Request)
    func loadCalendar(_ request: Model.Calendar.Request)
    func addToDB (title: String, date : Date, notify1: Date, notify2: Date, currentDate: Date)
    func removeForDB (dateEdit: Date)
    // func load(_ request: Model..Request)
}

protocol CalendarEditPresentationLogic {
    typealias Model = CalendarEditModel
    func presentStart(_ response: Model.Start.Response)
    func presentCalendar(_ response: Model.Calendar.Response)
    // func present(_ response: Model..Response)
}

protocol CalendarEditDisplayLogic: AnyObject {
    typealias Model = CalendarEditModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayCalendar(_ viewModel: Model.Calendar.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol CalendarEditAnalitics: AnyObject {
    typealias Model = CalendarEditModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol CalendarEditRoutingLogic {
    func routeToCalendar()
}

