//
//  AccessRecoveryProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

protocol AccessRecoveryBusinessLogic {
    typealias Model = AccessRecoveryModel
    func loadStart(_ request: Model.Start.Request)
    func loadResetPassword(_ request: Model.ResetPassword.Request)
    // func load(_ request: Model..Request)
}

protocol AccessRecoveryPresentationLogic {
    typealias Model = AccessRecoveryModel
    func presentStart(_ response: Model.Start.Response)
    func presentResetPassword(_ response: Model.ResetPassword.Response)
    // func present(_ response: Model..Response)
}

protocol AccessRecoveryDisplayLogic: AnyObject {
    typealias Model = AccessRecoveryModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayResetPassword(_ viewModel: Model.ResetPassword.ViewModel)
    
    // func display(_ viewModel: Model..ViewModel)
}

protocol AccessRecoveryAnalitics: AnyObject {
    typealias Model = AccessRecoveryModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol AccessRecoveryRoutingLogic {
    func routeToResetPassword()
}

