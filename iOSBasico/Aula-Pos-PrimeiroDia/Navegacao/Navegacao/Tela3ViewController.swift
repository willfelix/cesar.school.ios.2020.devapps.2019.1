//
//  Tela1ViewController.swift
//  Navegacao
//
//  Created by aluno on 28/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class Tela3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindDaTela3(segue: UIStoryboardSegue) {
        print("--> unwindDaTela3 (( segue para voltar para tela 1 )) <<--")
    }

}
