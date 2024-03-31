//
//  PetEditPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

final class PetEditPresenter: PetEditPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: PetEditDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentPets(_ response: Model.Pets.Response) {
        view?.displayPets(Model.Pets.ViewModel())
    }
}

