//
//  PetsViewController.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 11.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage

final class PetsViewController: UIViewController,
                                PetsDisplayLogic {
    
    
    
    // MARK: - Constants
    private enum Constants {
        static let fatalError: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    private let label: UILabel = UILabel()
    private let addButton: UIButton = UIButton()
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    #warning("TODO: petsArray в интерактор")
    var petsArray: [PetModel] = []
    
    private let router: PetsRoutingLogic
    private let interactor: PetsBusinessLogic
    
    // MARK: - LifeCycle
    init(
        router: PetsRoutingLogic,
        interactor: PetsBusinessLogic
    ) {
        self.router = router
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        interactor.loadStart(Model.Start.Request())
    }
    
    // MARK: - Configuration
    private func configureUI() {
        configureAddButton()
        configureLabel()
        configureCollection { Bool in
            if Bool == true {
                self.addPetsToCollectionView()
                self.view.addSubview(self.collectionView)
                    self.collectionView.pinHorizontal(to: self.view, 10)
                            self.collectionView.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
                            self.collectionView.pinTop(to: self.label.bottomAnchor, 15)
            }
        }
    }
    
    private func configureAddButton() {
        addButton.tintColor = .systemPink
        view.addSubview(addButton)
        
        addButton.setWidth(30)
        addButton.setHeight(30)
        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        addButton.pinRight(to: view.trailingAnchor, 15)
        
        if let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)) {
            let largerImage = image.withRenderingMode(.alwaysTemplate)
            addButton.setImage(largerImage, for: .normal)
        }
       
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    private func configureLabel() {
        view.addSubview(label)
        
        label.text = "my_pets".localized
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        label.textColor = UIColor.label
        label.pinCenterY(to: addButton.centerYAnchor)
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
    }
    
    func configureCollection(completion: @escaping (Bool) -> Void) {
        #warning("TODO: Interactor")
        collectionView.reloadData()
        let currId = (Auth.auth().currentUser?.uid)!
        let collectionns = Firestore.firestore().collection("users_new").document(currId).collection("pets")
        collectionns.order(by: "Date", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка получения документов: \(error.localizedDescription)")
                completion(false)
            } else {
                var petModels: [PetModel] = []
                let dispatchGroup = DispatchGroup()
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if !data.isEmpty {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale.current
                        dateFormatter.dateFormat = "d MMMM yyyy"
                        let name = data["Name"] as! String
                        let date = data["Date"] as! String
                        let breed = data["Breed"] as! String
                        let type = data["Type"] as! String
                        let color = data["Color"] as! String
                        let yearVactination: String
                        let lastVactination: String
                        let lastBath: String
                        if let yearVactinationF = data["YearVaccination"] as? Timestamp {
                            yearVactination = dateFormatter.string(from: yearVactinationF.dateValue())
                        } else {
                            yearVactination = ""
                        }
                        
                        if let lastVactinationF = data["LastVaccination"] as? Timestamp {
                            lastVactination = dateFormatter.string(from: lastVactinationF.dateValue())
                        } else {
                            lastVactination = ""
                        }
                        
                        if let lastBathF = data["LastBathing"] as? Timestamp {
                            lastBath = dateFormatter.string(from: lastBathF.dateValue())
                        } else {
                            lastBath = ""
                        }
                      
                       
                        let birthF: Timestamp = data["DateBirthday"] as! Timestamp
                        let birth = birthF.dateValue()
                       
                        let storageRef = Storage.storage().reference().child("users/\(currId)/pets/\(data["Date"] as! String).jpg")
                        
                        dispatchGroup.enter()
                        storageRef.getData(maxSize: 10 * 1024 * 1024) { dataImage, error in
                            defer {
                                dispatchGroup.leave()
                            }
                            
                            if let error = error {
                                print("Ошибка загрузки фотографии из Firebase Storage: \(error.localizedDescription)")
                            } else {
                                if let imageData = dataImage, let image = UIImage(data: imageData) {
                                    let petModel = PetModel(name: name, image: image, breed: breed, type: type, color: color, lastVactination: lastVactination, yearVactination: yearVactination, birth: birth, lastBath: lastBath, date: date)
                                    petModels.append(petModel)
                                    print(name)
                                } else {
                                    print("Не удалось преобразовать данные в изображение")
                                }
                            }
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    print("Все фотографии успешно загружены")
                    self.petsArray = petModels.sorted { (petModel1: PetModel, petModel2: PetModel) -> Bool in
                        return petModel1.date! > petModel2.date!
                    }
                    
                    completion(true)
                }
            }
        }
    }



    private func addPetsToCollectionView() {
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.invalidateLayout()
        }
        
        collectionView.register(PetCell.self, forCellWithReuseIdentifier: "pet")
        
        
       
    }

    
    // MARK: - Actions
    @objc
    private func addTapped() {
        interactor.loadPetAdd(PetsModel.PetAdd.Request())
    }
    
    // MARK: - DisplayLogic
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        configureUI()
    }
    func displayPetAdd(_ viewModel: Model.PetAdd.ViewModel) {
        router.routeToPetAdd()
    }
    func displayPetPage(_ viewModel: Model.Pets.ViewModel) {
        router.routeToPetPage(pet: viewModel.pet)
    }
}

extension PetsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCell.reuseId, for: indexPath)
        
        guard let petCell = cell as? PetCell else {
            return cell
        }
        
        let pet = petsArray[indexPath.row]
        petCell.configure(with: pet)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pet = petsArray[indexPath.item]
        interactor.loadPetPage(PetsModel.Pets.Request(pet: pet))
    }
}
