//
//  JournalEditProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 29.03.2024.
//

import UIKit

protocol JournalEditBusinessLogic {
    typealias Model = JournalEditModel
    func loadStart(_ request: Model.Start.Request)
    func loadJournal(_ request: Model.Journal.Request)
    func addToDB (title: String, note : String, date : Date, dateEdit : Date)
    func removeForDB (date: Date)
    // func load(_ request: Model..Request)
}

protocol JournalEditPresentationLogic {
    typealias Model = JournalEditModel
    func presentStart(_ response: Model.Start.Response)
    func presentJournal(_ response: Model.Journal.Response)
    // func present(_ response: Model..Response)
}

protocol JournalEditDisplayLogic: AnyObject {
    typealias Model = JournalEditModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayJournal(_ viewModel: Model.Journal.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol JournalEditAnalitics: AnyObject {
    typealias Model = JournalEditModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol JournalEditRoutingLogic {
    func routeToJournal()
}

