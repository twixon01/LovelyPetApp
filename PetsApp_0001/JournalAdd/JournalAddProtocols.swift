//
//  JournalAddProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

protocol JournalAddBusinessLogic {
    typealias Model = JournalAddModel
    func loadStart(_ request: Model.Start.Request)
    func addToDB (title: String, note : String, date : String)
    func loadJournal(_ request: Model.Journal.Request)
    // func load(_ request: Model..Request)
}

protocol JournalAddPresentationLogic {
    typealias Model = JournalAddModel
    func presentStart(_ response: Model.Start.Response)
    func presentJournal(_ response: Model.Journal.Response)
    // func present(_ response: Model..Response)
}

protocol JournalAddDisplayLogic: AnyObject {
    typealias Model = JournalAddModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayJournal(_ viewModel: Model.Journal.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol JournalAddAnalitics: AnyObject {
    typealias Model = JournalAddModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol JournalAddRoutingLogic {
    func routeTo()
    func routeToJournal()
}

