//
//  PetsProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

protocol PetsBusinessLogic {
    typealias Model = PetsModel
    func loadStart(_ request: Model.Start.Request)
    func loadPetAdd(_ request: Model.PetAdd.Request)
    func loadPetPage(_ request: Model.Pets.Request)
    // func load(_ request: Model..Request)
}

protocol PetsPresentationLogic {
    typealias Model = PetsModel
    func presentStart(_ response: Model.Start.Response)
    func presentPetAdd(_ response: Model.PetAdd.Response)
    func presentPetPage(_ response: Model.Pets.Response)
    // func present(_ response: Model..Response)
}

protocol PetsDisplayLogic: AnyObject {
    typealias Model = PetsModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayPetAdd(_ viewModel: Model.PetAdd.ViewModel)
    func displayPetPage(_ viewModel: Model.Pets.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol PetsAnalitics: AnyObject {
    typealias Model = PetsModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol PetsRoutingLogic {
    func routeToPetAdd()
    func routeToPetPage(pet: PetModel)
}

