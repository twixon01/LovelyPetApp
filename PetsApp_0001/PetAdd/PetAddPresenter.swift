//
//  PetAddPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

final class PetAddPresenter: PetAddPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: PetAddDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentPets(_ response: Model.Pets.Response) {
        view?.displayPets(Model.Pets.ViewModel())
    }
}

