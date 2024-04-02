//
//  String+extension.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 04.04.2024.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
}
