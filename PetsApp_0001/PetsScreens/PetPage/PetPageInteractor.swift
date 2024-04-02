//
//  PetPageInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

final class PetPageInteractor: PetPageBusinessLogic {
    // MARK: - Fields
    private let presenter: PetPagePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PetPagePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadPetEdit(_ request: Model.Pets.Request) {
        presenter.presentPetEdit(Model.Pets.Response(pet: request.pet))
    }
    
    
}

