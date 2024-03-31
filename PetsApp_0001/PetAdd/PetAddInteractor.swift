//
//  PetAddInteractir.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import Firebase
import UIKit
import FirebaseStorage

final class PetAddInteractor: PetAddBusinessLogic {
    // MARK: - Fields
    private let presenter: PetAddPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PetAddPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadPets(_ request: Model.Pets.Request) {
        addToDB(name: request.name, type: request.type, dateBirth: request.dateBirth, date: Date(), photo: request.photo!, color: request.color!, breed: request.breed)
    }
    
    func addToDB (name: String, type : String, dateBirth: Date, date: Date, photo: UIImage, color: String, breed: String) {
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users_new").document(uid).collection("pets").document("\(stringFromDate(date))").setData(["Name": name.capitalized, "Type": type, "DateBirthday": dateBirth, "Date": stringFromDate(date), "LastVaccination": "", "YearVaccination": "", "Color": color, "LastBathing": "", "Breed": breed]){ error in
            if let error = error {
                print("Ошибка при обновлении данных: \(error.localizedDescription)")
            } else {
                print("Поле успешно добавлено к документу")
            }
        }
        guard let imageData = photo.jpegData(compressionQuality: 1) else {
            print("Не удалось получить данные изображения")
            return
        }
     
            
            
        let storageRef = Storage.storage().reference().child("users").child(uid).child("pets").child("\(stringFromDate(date)).jpg")
            
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Ошибка при загрузке фотографии в Firebase Storage: \(error.localizedDescription)")
                } else {
                    print("Фотография успешно загружена в Firebase Storage")
                    self.presenter.presentPets(Model.Pets.Response())
                }
            }
            
        }
    }
    

