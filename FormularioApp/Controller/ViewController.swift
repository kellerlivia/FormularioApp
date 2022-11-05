//
//  ViewController.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 03/11/22.
//

import UIKit

class ViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, PickerViewNumeroDeParcela {
    
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var viewConfirmation: UIView!
    @IBOutlet weak var viewLogo: UIView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var labelParcela: UILabel!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcela = PickerViewParcela()
    
    var precoDoIngresso: Double = 210.00
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(notification:)), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcela.delegate = self
    }
    
    @objc func aumentarScrollView(notification: Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 750)
    }
    
    @IBAction func buttonConfirm(_ sender: UIButton) {
        let textFieldsAreFilled = ValidateForm().checkTextFieldsFilled(textFields: textFields)
        let textFieldsAreValid = ValidateForm().checkTextFieldsValid(listOfTextFields: textFields)
        
        if textFieldsAreFilled && textFieldsAreValid {
            let alert = ValidateForm().displaysFilledTextFieldsNotification(title: "Parabéns", message: "Compra realizada com sucesso")
            present(alert, animated: true, completion: nil)
        } else {
            let alert = ValidateForm().displaysFilledTextFieldsNotification(title: "Atenção", message: "Preencha corretamente todos os campos")
            present(alert, animated: true, completion: nil)
        }
    }
    
    func buscaTextField(tipoDeTextField:TypesOfTextFields, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TypesOfTextFields(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @IBAction func textFieldCepUpdateValue(_ sender: UITextField) {
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: sender.text!, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            })
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            })
            
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        
        sender.inputView = pickerView
    }
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { textFieldMes in
            textFieldMes.text = mes
        }
    }
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        
        sender.inputView = pickerView
        
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { textFieldAno in
            textFieldAno.text = ano
        }
    }
    
    @IBAction func textFieldCodigoDeSeguranca(_ sender: UITextField) {
        guard let texto = sender.text else { return }
        
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranc) { textFieldCodigoDeSeguranca in
                textFieldCodigoDeSeguranca.text = String(codigo)
            }
        } else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranc) { textFieldCodigoDeSeguranca in
                textFieldCodigoDeSeguranca.text = texto
            }
        }
    }
    
    @IBAction func textFieldParcelas(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcela
        pickerView.dataSource = pickerViewParcela
        
        sender.inputView = pickerView
    }
    
    func numeroDeParcela(parcela: String) {
        self.buscaTextField(tipoDeTextField: .parcela) { textFieldParcela in
            textFieldParcela.text = "\(parcela)x"
            
            let calculoDaParcela = "\(Double(precoDoIngresso)/Double(parcela)!)"
            self.labelParcela.text = String(format: "%@x R$%@ (ou \(precoDoIngresso) à vista)", parcela, calculoDaParcela)
        }
    }
    
}
