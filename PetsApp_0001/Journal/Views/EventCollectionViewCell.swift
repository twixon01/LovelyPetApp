//
//  EventCollectionViewCell.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "event"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let dateFormatter: DateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateFormatter.dateStyle = .full
        configureUI()
    }
    
    private func configureUI() {
        configureWrap()
        configureTitleLabel()
        configureDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: EventModel) {
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        titleLabel.text = event.title
        dateLabel.text = dateFormatter.string(from: event.date)
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = UIColor.cellBackground
        wrapView.layer.cornerRadius = 13
        wrapView.layer.borderColor = UIColor.shadowColor
        wrapView.layer.borderWidth = 1
        wrapView.pinHorizontal(to: self, 5)
        wrapView.pinVertical(to: self, 5.75)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = .label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.pinCenterY(to: wrapView.centerYAnchor)
        titleLabel.pinLeft(to: wrapView.leadingAnchor, 10)
        titleLabel.setWidth(280)
    }
    
    private func configureDateLabel() {
        wrapView.addSubview(dateLabel)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.pinCenterY(to: titleLabel.centerYAnchor)
        dateLabel.pinRight(to: wrapView.trailingAnchor, 10)
    }

//    var event: EventModel? {
//        didSet {
//            nameLabel.text = event?.title
//            descriptionLabel.text = event?.description
//            if let date = event?.date {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "dd/MM/yyyy" // Формат даты по вашему выбору
//                dateLabel.text = dateFormatter.string(from: date)
//            }
//            petNameLabel.text = event?.petName
//        }
//    }
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.text = "Привет"
//        return label
//    }()
//
//    private let descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.text = "Как дела"
//        return label
//    }()
//
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        return label
//    }()
//
//    private let petNameLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(nameLabel)
//        addSubview(descriptionLabel)
//        addSubview(dateLabel)
//        addSubview(petNameLabel)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // Update frames for labels according to your layout
//    }
}
