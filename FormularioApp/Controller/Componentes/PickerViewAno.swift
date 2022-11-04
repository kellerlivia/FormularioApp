//
//  PickerViewAno.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 04/11/22.
//

import UIKit

protocol PickerViewAnoSelecionado {
    func anoSelecionado(ano: String)
}

class PickerViewAno: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewAnoSelecionado?
    let listaDeAnos = ["2022", "2023", "2024", "2025", "2026", "2027"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaDeAnos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let anoAtual = listaDeAnos[row]
        return anoAtual
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: listaDeAnos[row])
        }
    }
}
