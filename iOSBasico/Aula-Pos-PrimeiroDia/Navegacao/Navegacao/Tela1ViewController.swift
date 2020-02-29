//
//  ViewController.swift
//  Navegacao
//
//  Created by aluno on 28/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class Tela1ViewController: UIViewController {

    @IBOutlet weak var tituloTela1Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func abrirTela2(_ sender: Any) {
        
        performSegue(withIdentifier: "irTela2", sender: nil)
        
    }
    
//    @IBAction func unwindTela1(segue: UIStoryboardSegue) {
//        print("--> unwindTela1 (( segue para voltar para tela 1 )) <<--")
//    }
    
    @IBAction func unwindVoltar(for unwindSegue: UIStoryboardSegue) {
        
    }
    
}

