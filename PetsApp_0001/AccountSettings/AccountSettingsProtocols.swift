//
//  AccountSettingsProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

protocol AccountSettingsBusinessLogic {
    typealias Model = AccountSettingsModel
    func loadStart(_ request: Model.Start.Request)
    func userInfo(completion: @escaping (UserModel) -> Void)
    // func load(_ request: Model..Request)
}

protocol AccountSettingsPresentationLogic {
    typealias Model = AccountSettingsModel
    func presentStart(_ response: Model.Start.Response)
    // func present(_ response: Model..Response)
}

protocol AccountSettingsDisplayLogic: AnyObject {
    typealias Model = AccountSettingsModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol AccountSettingsAnalitics: AnyObject {
    typealias Model = AccountSettingsModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol AccountSettingsRoutingLogic {
    func routeTo()
}

