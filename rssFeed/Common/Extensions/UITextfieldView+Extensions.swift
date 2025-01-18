//
//  UITextfieldView+Extensions.swift
//  rssFeed
//
//  Created by Toni Pavic on 06.01.2025..
//

import UIKit

extension UITextField {
    func addClearButton() {
        let clearButton = UIButton(type: .system)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = Colors.primary
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc private func clearText() {
        self.text = Strings.empty
        sendActions(for: .editingChanged)
    }
}
