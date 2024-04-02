//
//  AccountSettingsInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 01.04.2024.
//

import UIKit
import Firebase

final class AccountSettingsInteractor: AccountSettingsBusinessLogic {
    // MARK: - Fields
    private let presenter: AccountSettingsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: AccountSettingsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func userInfo(completion: @escaping (UserModel) -> Void) {
        var userModel: UserModel = UserModel()
        
        let currId = (Auth.auth().currentUser?.uid)!
        Firestore.firestore().collection("users_new").document(currId).getDocument { (document, error) in
            if let error = error {
                print("Ошибка получения документов: \(error.localizedDescription)")
                completion(userModel)
            } else {
                let data = document!.data()
                if !data!.isEmpty {
                    let name = data!["Name"] as! String
                    let email = data!["Email"] as! String
                    let userM = UserModel(name: name, email: email)
                    userModel = userM
                }
            }
            completion(userModel)
        }
    }
}


