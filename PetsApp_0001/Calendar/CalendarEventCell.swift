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
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "EEEE, d MMMM, yyyy' 'HH:mm"
        titleLabel.text = event.title
        dateLabel.text = "Дата: \(dateFormatter.string(from: event.date))"
        let differnce = differenceBetweenDates(date1: event.notification1, date2: event.date)
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: UIColor.label
        ]
        let days1AttributedString: NSAttributedString
        let hours1AttributedString: NSAttributedString
        let minute1AttributedString: NSAttributedString
        
        
        let attributedText = NSMutableAttributedString(string: "Напомнить за: ")
        
        if differnce!.days < 1 {
            if differnce!.hours < 1 {
                if differnce!.minutes > 0 {
                    if differnce!.minutes % 10 == 1 {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуту", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    } else if differnce!.minutes % 10 < 5 {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуты", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    }
                    else {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минут", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    }
                }
            } else {
                if differnce!.hours == 1  || differnce!.hours == 21 {
                    hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) час ", attributes: boldAttributes)
                    attributedText.append(hours1AttributedString)
                } else if differnce!.hours < 5 || (differnce!.hours < 24 && differnce!.hours > 20) {
                    hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) часа ", attributes: boldAttributes)
                    attributedText.append(hours1AttributedString)
                } else {
                    hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) часов ", attributes: boldAttributes)
                    attributedText.append(hours1AttributedString)
                }
                if differnce!.minutes > 0 {
                    if differnce!.minutes % 10 == 1 {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуту", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    } else if differnce!.minutes % 10 < 5 {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуты", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    }
                    else {
                        minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минут", attributes: boldAttributes)
                        attributedText.append(minute1AttributedString)
                    }
                }
                
            }
        } else if differnce!.hours < 1 {
            if differnce!.days % 10 == 1 && !(differnce!.days == 11) {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) день ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            } else if differnce!.days % 10 < 5 && !(differnce!.days > 10 && differnce!.days < 20) {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) дня ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            } else {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) дней ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            }
            if differnce!.minutes > 0 {
                if differnce!.minutes % 10 == 1 {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуту", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                } else if differnce!.minutes % 10 < 5 {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуты", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                }
                else {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минут", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                }
            }
        } else {
            if differnce!.days % 10 == 1 && !(differnce!.days == 11) {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) день ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            } else if differnce!.days % 10 < 5 && !(differnce!.days > 10 && differnce!.days < 20) {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) дня ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            } else {
                days1AttributedString = NSAttributedString(string: "\(differnce!.days) дней ", attributes: boldAttributes)
                attributedText.append(days1AttributedString)
            }
            if differnce!.hours == 1  || differnce!.hours == 21 {
                hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) час ", attributes: boldAttributes)
                attributedText.append(hours1AttributedString)
            } else if differnce!.hours < 5 || (differnce!.hours < 24 && differnce!.hours > 20) {
                hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) часа ", attributes: boldAttributes)
                attributedText.append(hours1AttributedString)
            } else {
                hours1AttributedString = NSAttributedString(string: "\(differnce!.hours) часов ", attributes: boldAttributes)
                attributedText.append(hours1AttributedString)
            }
           
            if differnce!.minutes > 0 {
                if differnce!.minutes % 10 == 1 {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуту", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                } else if differnce!.minutes % 10 < 5 {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минуты", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                }
                else {
                    minute1AttributedString = NSAttributedString(string: "\(differnce!.minutes) минут", attributes: boldAttributes)
                    attributedText.append(minute1AttributedString)
                }
            }
        }
        
        
        
        notificationLabel.attributedText = attributedText
        
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = UIColor.cellBackground
        wrapView.layer.cornerRadius = 20
        wrapView.layer.shadowColor = UIColor.shadowColor
        wrapView.layer.shadowOpacity = 25
        wrapView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        //        wrapView.setWidth(190)
        wrapView.pinHorizontal(to: self, 5)
        wrapView.pinVertical(to: self, 5)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = .label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
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
    
    private func differenceBetweenDates(date1: Date, date2: Date) -> (days: Int, hours: Int, minutes: Int)? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: date1, to: date2)
        guard let days = components.day, let hours = components.hour, let minutes = components.minute else {
            return nil
        }
        
        return (days, hours, minutes)
    }
    
}
