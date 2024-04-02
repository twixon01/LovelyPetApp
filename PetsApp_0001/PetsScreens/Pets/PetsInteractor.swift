//
//  PetsInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

final class PetsInteractor: PetsBusinessLogic {
    // MARK: - Fields
    private let presenter: PetsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PetsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadPetAdd(_ request: Model.PetAdd.Request) {
        presenter.presentPetAdd(Model.PetAdd.Response())
    }
    
    func loadPetPage(_ request: Model.Pets.Request) {
        presenter.presentPetPage(Model.Pets.Response(pet: request.pet))
    }
}

