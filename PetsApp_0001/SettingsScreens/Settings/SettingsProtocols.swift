//
//  SettingsProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

protocol SettingsBusinessLogic {
    typealias Model = SettingsModel
    func loadStart(_ request: Model.Start.Request)
    func loadAuth(_ request: Model.AuthMy.Request)
    func loadAccountSettings(_ request: Model.AccountSettings.Request)
    // func load(_ request: Model..Request)
}

protocol SettingsPresentationLogic {
    typealias Model = SettingsModel
    func presentStart(_ response: Model.Start.Response)
    func presentAuth(_ response: Model.AuthMy.Response)
    func presentAccountSettings(_ response: Model.AccountSettings.Response)
    // func present(_ response: Model..Response)
}

protocol SettingsDisplayLogic: AnyObject {
    typealias Model = SettingsModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayAuth(_ viewModel: Model.AuthMy.ViewModel)
    func displayAccountSettings(_ viewModel: Model.AccountSettings.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol SettingsAnalitics: AnyObject {
    typealias Model = SettingsModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol SettingsRoutingLogic {
    func routeToAuth()
    func routeToAccountSettings()
}

