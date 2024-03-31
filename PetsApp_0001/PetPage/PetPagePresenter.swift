//
//  PetPagePresenter.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

final class PetPagePresenter: PetPagePresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    weak var view: PetPageDisplayLogic?
    
    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        view?.displayStart(Model.Start.ViewModel())
    }
    
    func presentPetEdit(_ response: Model.Pets.Response) {
        view?.displayPetEdit(Model.Pets.ViewModel(pet: response.pet))
    }
}

