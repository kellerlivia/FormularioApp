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
        return true
    }
    
    func displaysFilledTextFieldsNotification(title: String, message: String) -> UIAlertController {
        let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        notification.addAction(button)
        
        return notification
    }

}
