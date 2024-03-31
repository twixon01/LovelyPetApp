//
//  PetEditProtocols.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//
import UIKit

protocol PetEditBusinessLogic {
    typealias Model = PetEditModel
    func loadStart(_ request: Model.Start.Request)
    func removeForDB (date: String)
    func addToDB (name: String, type : String, dateBirth: Date, date: String, photo: UIImage, color: String, breed: String, lastVact: Date, yearVact: Date, lastBath: Date)
    // func load(_ request: Model..Request)
}

protocol PetEditPresentationLogic {
    typealias Model = PetEditModel
    func presentStart(_ response: Model.Start.Response)
    func presentPets(_ response: Model.Pets.Response)
    // func present(_ response: Model..Response)
}

protocol PetEditDisplayLogic: AnyObject {
    typealias Model = PetEditModel
    func displayStart(_ viewModel: Model.Start.ViewModel)
    func displayPets(_ viewModel: Model.Pets.ViewModel)
    // func display(_ viewModel: Model..ViewModel)
}

protocol PetEditAnalitics: AnyObject {
    typealias Model = PetEditModel
    func logStart(_ info: Model.Start.Info)
    // func log(_ viewModel: Model..Info)
}

protocol PetEditRoutingLogic {
    func routeToPets()
}

