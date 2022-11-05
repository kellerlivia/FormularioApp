//
//  PickerViewParcela.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 05/11/22.
//

import UIKit

protocol PickerViewNumeroDeParcela {
    func numeroDeParcela(parcela: String)
}


class PickerViewParcela: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewNumeroDeParcela?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)x"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.numeroDeParcela(parcela: "\(row+1)")
        }
    }
}
