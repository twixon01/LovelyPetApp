//
//  PetEditInteractor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 18.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage

final class PetEditInteractor: PetEditBusinessLogic {
    
    // MARK: - Fields
    private let presenter: PetEditPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PetEditPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BusinessLogic
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func addToDB (name: String, type : String, dateBirth: Date, date: String, photo: UIImage, color: String, breed: String, lastVact: Date, yearVact: Date, lastBath: Date) {
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users_new").document(uid).collection("pets").document(date).setData(["Name": name.capitalized, "Type": type, "DateBirthday": dateBirth, "Date": date, "LastVaccination": lastVact, "YearVaccination": yearVact, "Color": color, "LastBathing": lastBath, "Breed": breed]){ error in
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
        
        
        
        let storageRef = Storage.storage().reference().child("users/\(uid)/pets/\(date).jpg")
        storageRef.delete { error in
            if let error = error {
                print("Ошибка при удалении файла: \(error)")
            } else {
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
        
        
    }
    
    func removeForDB (date: String) {
        func stringFromDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        let uid = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("users_new").document(uid).collection("pets").document(date).delete() 
        Storage.storage().reference().child("users/\(uid)/pets/\(date).jpg").delete { error in
            if let error = error {
                print("Ошибка при удалении файла: \(error)")
            } else {
                print("Файл успешно удален")
                self.presenter.presentPets(Model.Pets.Response())
            }
        }
        
    }
}

