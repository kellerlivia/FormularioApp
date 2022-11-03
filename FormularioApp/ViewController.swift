//
//  ViewController.swift
//  FormularioApp
//
//  Created by Livia Carvalho Keller on 03/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageBanner.layer.cornerRadius = 10
        self.imageBanner.layer.masksToBounds = true
    }
}

