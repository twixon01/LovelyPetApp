//
//  PetPageProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

protocol PetPageBusinessLogic {
    typealias Model = PetPageModel
    func loadStart(_ request: Model.Start.Request)
    func loadPetEdit(_ request: Model.Pets.Request)
    // func load(_ request: Model..Request)
}

protocol PetPagePresentationLogic {
    typealias Model = PetPageModel
    func presentStart(_ response: Model.Start.Response)
    func presentPetEdit(_ response: Model.Pets.Response)
    // func present(_ response: Model..Response)
}

protocol PetPageDisplayLogic: AnyObject {
    typealias Model = PetPageModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayPetEdit(_ viewModel: Model.Pets.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol PetPageAnalitics: AnyObject {
    typealias Model = PetPageModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol PetPageRoutingLogic {
    func routeToPetEdit(pet: PetModel)
}

