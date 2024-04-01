//
//  JournalProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

protocol JournalBusinessLogic {
    typealias Model = JournalModel
    func loadStart(_ request: Model.Start.Request)
    func loadSettings(_ request: Model.Settings.Request)
    func loadPets(_ request: Model.Pets.Request)
    func loadCalendar(_ request: Model.Calendar.Request)
    func loadJournalAdd(_ request: Model.JournalAdd.Request)
    func loadJournalEdit(_ request: Model.JournalEdit.Request)
    // func load(_ request: Model..Request)
}

protocol JournalPresentationLogic {
    typealias Model = JournalModel
    func presentStart(_ response: Model.Start.Response)
    func presentSettings(_ response: Model.Settings.Response)
    func presentPets(_ response: Model.Pets.Response)
    func presentCalendar(_ response: Model.Calendar.Response)
    func presentJournalAdd(_ response: Model.JournalAdd.Response)
    func presentJournalEdit(_ response: Model.JournalEdit.Response)
    // func present(_ response: Model..Response)
}

protocol JournalDisplayLogic: AnyObject {
    typealias Model = JournalModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displaySettings(_ viewModel: Model.Settings.ViewModel)
    func displayPets(_ viewModel: Model.Pets.ViewModel)
    func displayCalendar(_ viewModel: Model.Calendar.ViewModel)
    func displayJournalAdd(_ viewModel: Model.JournalAdd.ViewModel)
    func displayJournalEdit(_ viewModel: Model.JournalEdit.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol JournalAnalitics: AnyObject {
    typealias Model = JournalModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol JournalRoutingLogic {
    func routeToSettings()
    func routeToPets()
    func routeToCalendar()
    func routeToJournalAdd()
    func routeToJournalEdit(event: EventModel)
}

