//
//  ViewController.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 03/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var viewConfirmation: UIView!
    @IBOutlet weak var viewLogo: UIView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageBanner.layer.cornerRadius = 10
        self.imageBanner.layer.masksToBounds = true
        
        self.buttonConfirm.layer.cornerRadius = 10
        self.buttonConfirm.layer.masksToBounds = true
        
        self.viewConfirmation.layer.cornerRadius = 10
        self.viewConfirmation.layer.masksToBounds = true
        
        self.viewLogo.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 20 : 20
        self.viewLogo.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func buttonConfirm(_ sender: UIButton) {
        let textFieldsAreFilled = ValidateForm().checkTextFieldsFilled(textFields: textFields)
        let textFieldsAreValid = ValidateForm().checkTextFieldsValid(listOfTextFields: textFields)
        
        if textFieldsAreFilled && textFieldsAreValid {
            let alert = ValidateForm().displaysFilledTextFieldsNotification(title: "Parabéns", message: "Compra realizada com suceso")
            present(alert, animated: true, completion: nil)
        } else {
            let alert = ValidateForm().displaysFilledTextFieldsNotification(title: "Atenção", message: "Preencha corretamente todos os campos")
            present(alert, animated: true, completion: nil)
        }
    }
}

