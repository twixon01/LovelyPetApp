//
//  CalendarEventCell.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 12.03.2024.
//

import UIKit

final class CalendarEventCell: UICollectionViewCell {
    static let reuseId = "calendar event"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let notificationLabel: UILabel = UILabel()
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
        configureNotificationDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with event: CalendarEventModel) {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE, d MMMM, yyyy' 'HH:mm"
        titleLabel.text = event.title
        dateLabel.text = "Дата: \(dateFormatter.string(from: event.date))"
        #warning("TODO: check output")
        notificationLabel.text = "Напомнить за: \(Int(event.date.timeIntervalSince(event.notification)/3600)) час"
    }

    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = UIColor.cellBackground
        wrapView.layer.cornerRadius = 20
        wrapView.layer.shadowColor = UIColor.shadowColor
        wrapView.layer.shadowOpacity = 50
        wrapView.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        wrapView.pinHorizontal(to: self, 5)
        wrapView.pinVertical(to: self, 5)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.pinTop(to: wrapView, 10)
        titleLabel.pinHorizontal(to: wrapView, 10)
    }
    
    private func configureDateLabel() {
        wrapView.addSubview(dateLabel)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.pinHorizontal(to: wrapView, 10)
        dateLabel.pinTop(to: titleLabel.bottomAnchor, 10)
    }
    
    private func configureNotificationDateLabel() {
        wrapView.addSubview(notificationLabel)
        notificationLabel.font = UIFont.systemFont(ofSize: 12)
        notificationLabel.pinHorizontal(to: wrapView, 10)
        notificationLabel.pinTop(to: dateLabel.bottomAnchor, 10)
        notificationLabel.pinBottom(to: wrapView, 10)
    }
}
