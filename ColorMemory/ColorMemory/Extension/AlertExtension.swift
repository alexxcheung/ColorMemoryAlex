//
//  AlertExtension.swift
//  ColorMemory
//
//  Created by Alex Cheung on 26/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

extension UIAlertController {

    func isValidName(_ name: String) -> Bool {
        return name.count > 0 && name.count < 20
    }
    
    @objc func textDidChangeInLoginAlert() {
        if let name = textFields?[0].text,
            let action = actions.last {
            action.isEnabled = isValidName(name)
        }
    }

 
}
