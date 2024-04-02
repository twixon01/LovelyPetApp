//
//  AuthProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

protocol AuthBusinessLogic {
    typealias Model = AuthModel
    func loadStart(_ request: Model.Start.Request)
    func loadAccessRecovery(_ request: Model.AccessRecovery.Request)
    func loadRegistration(_ request: Model.Registration.Request)
    func loadJournal(_ request: Model.Journal.Request)
}

protocol AuthPresentationLogic {
    typealias Model = AuthModel
    func presentStart(_ response: Model.Start.Response)
    func presentAccessRecovery(_ response: Model.AccessRecovery.Response)
    func presentRegistration(_ response: Model.Registration.Response)
    func presentJournal(_ response: Model.Journal.Response)
}

protocol AuthDisplayLogic: AnyObject {
    typealias Model = AuthModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayAccessRecovery(_ viewModel: Model.AccessRecovery.ViewModel)
    func displayRegistration(_ viewModel: Model.Registration.ViewModel)
    func displayJournal(_ viewModel: Model.Journal.ViewModel)
}

protocol AuthRoutingLogic {
    func routeToAccessRecovery()
    func routeToRegistration()
    func routeToJournal()
}

