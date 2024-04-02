//
//  PetCell.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

final class PetCell: UICollectionViewCell {
    static let reuseId = "pet"
    
    private let wrapView: UIView = UIView()
    private let nameLabel: UILabel = UILabel()
    private let image: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        configureWrap()
        configureImage()
        configureNameLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pet: PetModel) {
        if let petBirthday = pet.birthday {
            nameLabel.text = "\(pet.name), \(Calendar.current.dateComponents([.year], from: Date()).year! - Calendar.current.dateComponents([.year], from: petBirthday).year!) год"
        } else {
            nameLabel.text = pet.name
        }
        
        image.image = pet.image
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = UIColor.cellBackground
        wrapView.layer.cornerRadius = 20
        wrapView.layer.shadowColor = UIColor.shadowColor
        wrapView.layer.shadowOpacity = 25
        wrapView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        wrapView.pinHorizontal(to: self, 5)
        wrapView.pinVertical(to: self, 6)
    }
    
    private func configureImage() {
        wrapView.addSubview(image)
        image.setWidth(140)
        image.setHeight(140)
        image.layer.cornerRadius = 70
        image.clipsToBounds = true
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.systemPink.cgColor
        image.pinCenterX(to: wrapView.centerXAnchor)
        image.pinTop(to: wrapView.topAnchor, 10)
    }
    
    private func configureNameLabel() {
        wrapView.addSubview(nameLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.numberOfLines = 0
        nameLabel.pinBottom(to: wrapView.bottomAnchor, 9)
        nameLabel.pinCenterX(to: wrapView.centerXAnchor)
        nameLabel.numberOfLines = 1
        nameLabel.setWidth(175)
    }
}
