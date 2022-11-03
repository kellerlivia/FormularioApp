//
//  ValidateForm.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 03/11/22.
//

import UIKit
import CPF_CNPJ_Validator

enum TypesOfTextFields: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVencimento = 9
    case codigoDeSeguranc = 10
    case parcela = 11
}

class ValidateForm: NSObject {
    
    func checkTextFieldsFilled(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    func checkTextFieldsValid(listOfTextFields: [UITextField]) -> Bool {
        var dictionaryOfTextFields: Dictionary<TypesOfTextFields, UITextField> = [:]
        
        for textField in listOfTextFields {
            if let typesTextFields = TypesOfTextFields(rawValue: textField.tag) {
                dictionaryOfTextFields[typesTextFields] = textField
            }
        }
        
        guard let cpf = dictionaryOfTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else { return false }
        guard let email = dictionaryOfTextFields[.email], self.checkEmail(email.text!) else { return false }
        return true
    }
    
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func displaysFilledTextFieldsNotification(title: String, message: String) -> UIAlertController {
        let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        notification.addAction(button)
        
        return notification
    }

}
