//
//  RegistrationProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

protocol RegistrationBusinessLogic {
    typealias Model = RegistrationModel
    func loadStart(_ request: Model.Start.Request)
    func loadJournal(_ request: Model.Journal.Request)
    func authenticateUser(name: String, email: String, password: String, password2: String, completion: @escaping (Bool, String) -> Void)
    // func load(_ request: Model..Request)
}

protocol RegistrationPresentationLogic {
    typealias Model = RegistrationModel
    func presentStart(_ response: Model.Start.Response)
    func presentJournal(_ response: Model.Journal.Response)
}

protocol RegistrationDisplayLogic: AnyObject {
    typealias Model = RegistrationModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayJournal(_ viewModel: Model.Journal.ViewModel)
}

protocol RegistrationRoutingLogic {
    func routeToJournal()
}
