//
//  UIColor.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 31.03.2024.
//

import UIKit

// MARK: - Color methods

extension UIColor {
    static let systemBackground = UIColor { traitCollection -> UIColor in
        return ((traitCollection.userInterfaceStyle == .dark ? UIColor(named: "tink") : .white) ?? .white)
    }
    
    static let label = UIColor { traitCollection -> UIColor in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
    
    static let textLabel = UIColor { traitCollection -> UIColor in
        return traitCollection.userInterfaceStyle == .dark ? .lightGray : .black
    }
    
    static var textFieldBorder: CGColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }.cgColor
        } else {
            return UIColor.white.cgColor // Возвращаем белый цвет для версий iOS до 13.0, так как они не поддерживают темную тему
        }
    }
    
    static let cellBackground = UIColor { traitCollection -> UIColor in
        return traitCollection.userInterfaceStyle == .dark ? .systemGray6 : .white
    }
    
    static let shadowColor = UIColor { traitCollection -> UIColor in
        return traitCollection.userInterfaceStyle == .dark ? .systemPink : .systemPink
    }.cgColor
}
