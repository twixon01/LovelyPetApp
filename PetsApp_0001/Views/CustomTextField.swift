//
//  CustomTextField.swift
//  PetsApp_0001
//
//  Created by Илья Нестрогаев on 10.03.2024.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: - Constants
    enum Constants {
        
    }
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: CGRect())
        configureUI()
    }
    
    init(placeholder: String) {
        super.init(frame: CGRect())
        self.placeholder = placeholder
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configureUI() {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        textColor = UIColor.textLabel
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.textFieldBorder
    }
    
}
