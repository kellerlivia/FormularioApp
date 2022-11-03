//
//  ValidateForm.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 03/11/22.
//

import UIKit

class ValidateForm: NSObject {
    
    func checkTextFieldsFilled(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    func displaysFilledTextFieldsNotification(title: String, message: String) -> UIAlertController {
        let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        notification.addAction(button)
        
        return notification
    }

}
