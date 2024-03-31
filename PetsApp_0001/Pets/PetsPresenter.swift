//
//  PetsPresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

final class PetsPresenter: PetsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: PetsDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentPetAdd(_ response: Model.PetAdd.Response) {
        view?.displayPetAdd(Model.PetAdd.ViewModel())
    }
    
    func presentPetPage(_ response: Model.Pets.Response) {
        view?.displayPetPage(Model.Pets.ViewModel(pet: response.pet))
    }
}

