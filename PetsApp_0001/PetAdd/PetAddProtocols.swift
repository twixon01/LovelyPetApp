//
//  PetAddProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit

protocol PetAddBusinessLogic {
    typealias Model = PetAddModel
    func loadStart(_ request: Model.Start.Request)
    func loadPets(_ request: Model.Pets.Request)
    func addToDB (name: String, type : String, dateBirth: Date, date: Date, photo: UIImage, color: String, breed: String)
    // func load(_ request: Model..Request)
}

protocol PetAddPresentationLogic {
    typealias Model = PetAddModel
    func presentStart(_ response: Model.Start.Response)
    func presentPets(_ response: Model.Pets.Response)
    // func present(_ response: Model..Response)
}

protocol PetAddDisplayLogic: AnyObject {
    typealias Model = PetAddModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayPets(_ viewModel: Model.Pets.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol PetAddAnalitics: AnyObject {
    typealias Model = PetAddModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol PetAddRoutingLogic {
    func routeTo()
    func routeToPets()
}

