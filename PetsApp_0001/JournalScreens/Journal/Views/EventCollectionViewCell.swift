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
        
        let yearCurrent = Calendar.current.component(.year, from: Date())
        let yearNote = Calendar.current.component(.year, from: event.dateEdit)
        if yearCurrent > yearNote {
            dateFormatter.dateFormat = "d MMMM HH:mm, yyyy"
        } else {
            dateFormatter.dateFormat = "d MMMM HH:mm"
        }
        
        let titleSep = event.title!.trimmingCharacters(in: .whitespacesAndNewlines)
        if titleSep == "" {
            titleLabel.text = "new_note".localized
        } else {
            titleLabel.text = event.title
        }
       
        dateLabel.text = dateFormatter.string(from: event.dateEdit)
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
        titleLabel.setWidth(250)
    }
    
    private func configureDateLabel() {
        wrapView.addSubview(dateLabel)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.pinCenterY(to: titleLabel.centerYAnchor)
        dateLabel.pinRight(to: wrapView.trailingAnchor, 10)
    }
    
}
