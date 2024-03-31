//
//  EventCell.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

class EventCell: UIView
{
    var event: EventModel?
    
    let nameLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.boldSystemFont(ofSize: 18)
        return control
    }()
    
    let descriptionLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 12)
        return control
    }()
    
    let dateLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 12)
        return control
    }()
    
    let petNameLabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 12)
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with model: EventModel) {
        event = model
        configureNameLabel()
        configureDateLabel()
        configureDescriptionLabel()
        configurePetNameLabel()
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.text = event?.title
        nameLabel.pinTop(to: self, 10)
        nameLabel.pinLeft(to: self, 10)
    }
    
    private func configureDateLabel() {
        addSubview(dateLabel)
        
        if let date = event?.date {
            dateLabel.text = "\(Calendar.current.component(.day, from: date))/\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.year, from: date))"
        }
        
        dateLabel.pinCenterY(to: nameLabel)
        dateLabel.pinRight(to: self, 10)
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.text = event?.description
        descriptionLabel.pinTop(to: nameLabel.bottomAnchor, 5)
        descriptionLabel.pinLeft(to: nameLabel.leadingAnchor)
    }
    
    private func configurePetNameLabel() {
        addSubview(petNameLabel)
        
        petNameLabel.text = event?.petName
        petNameLabel.pinTop(to: descriptionLabel.bottomAnchor, 5)
        petNameLabel.pinLeft(to: nameLabel.leadingAnchor)
    }
}
