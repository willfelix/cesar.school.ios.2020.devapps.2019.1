//
//  ViewController.swift
//  RevisionNotes
//
//  Created by aluno on 29/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class Tela1ViewController: UIViewController {

    
    @IBOutlet weak var labelSimNao: UILabel!
    @IBOutlet weak var switchSimNao: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if switchSimNao.isOn {
            labelSimNao.text = "SIM"
        } else {
            labelSimNao.text = "NÃO"
        }
        
        
    }

    @IBAction func unwindTela1(segue: UIStoryboardSegue) {
        print("--> unwindTela1 (( segue para voltar para tela 1 )) <<--")
    }
    
    @IBAction func unwindTelaOlallll(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    

    @IBAction func irParaTela2(_ sender: UIButton) {
        
        labelSimNao.text = "OI!"
        performSegue(withIdentifier: "irTela2", sender: nil)
        
    }
    
    
    @IBAction func acaoSimNao(_ sender: UISwitch) {
        
        
        if sender.isOn {
            labelSimNao.text = "SIM"
        } else {
            labelSimNao.text = "NÃO"
        }
    }
    
    
    
    
}

