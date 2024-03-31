//
//  RegistrationInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import Firebase

final class RegistrationInteractor: RegistrationBusinessLogic {
    // MARK: - Fields
    private let presenter: RegistrationPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: RegistrationPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadJournal(_ request: Model.Journal.Request) {
        presenter.presentJournal(Model.Journal.Response())
    }
    
    func authenticateUser(name: String, email: String, password: String, password2 : String, completion: @escaping (Bool, String) -> Void) {
        if email.isEmpty || password.isEmpty || name.isEmpty || password2.isEmpty {
            completion(false, "")
        }
        else if password != password2 {
            completion(false, "password")
        }else {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if let result = result?.user {
                        Firestore.firestore().collection("users_new").document("\(result.uid)").setData([
                            "Name" : name,
                            "Email" : email,
                            "uid": result.uid
                            
                        ])
                        completion(true, "")
                    } else {
                        completion(true, "")
                    }
                } else {
                    completion(false, error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }
}

