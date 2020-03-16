//
//  ViewController.swift
//  SuperSenha
//
//  Created by Douglas Frari on 11/8/19.
//  Copyright © 2019 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlets 
    
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    @IBOutlet weak var btGeneratePasswords: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 
        let passwordsViewController = segue.destination as! PasswordViewController
        
        // forma mais segura (usar if let)
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            // se conseguir obter o valor do campo e converter para inteiro
            passwordsViewController.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            passwordsViewController.numberOfCharacters = numberOfCharacters
        }
        passwordsViewController.useNumbers = swNumbers.isOn
        passwordsViewController.useCapitalLetters = swCaptitalLetters.isOn
        passwordsViewController.useLetters = swLetters.isOn
        passwordsViewController.useSpecialCharacters = swSpecialCharacters.isOn
        
        // forcar encerrar o modo de edicao // remove o foco e libera teclado
        view.endEditing(true)
    }
    

    
    @IBAction func checkSwitchesEnabled(_ sender: UISwitch) {
        
        if (swLetters.isOn || swNumbers.isOn || swCaptitalLetters.isOn || swSpecialCharacters.isOn) {
            //
            btGeneratePasswords.isEnabled = true
            btGeneratePasswords.alpha = 1
        } else {
            btGeneratePasswords.isEnabled = false
            btGeneratePasswords.alpha  = 0.5
        }
        
    }
    
    

}

