//
//  PasswordViewController.swift
//  SuperSenha
//
//  Created by Douglas Frari on 11/9/19.
//  Copyright © 2019 CESAR School. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    var numberOfCharacters: Int = 10 // default se usuario nao enviar
    var numberOfPasswords: Int = 1
    var useLetters: Bool!
    var useNumbers: Bool!
    var useCapitalLetters: Bool!
    var useSpecialCharacters: Bool!
    
    @IBOutlet weak var tvPasswords: UITextView!
    
    var passwordGenerator: PasswordGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Quantudade de senhas informadas: \(numberOfCharacters)")
        
        self.passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters,
                               useLetters: useLetters,
                               useNumbers: useNumbers,
                               useCapitalLetters: useCapitalLetters,
                               useSpecialLetters: useSpecialCharacters)
        
        
        generatePasswords()
    }
    
    @IBAction func generatePasswordAgain(_ sender: Any) {
        generatePasswords()
    }
    
    func generatePasswords() {
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0)) // posiciona a scroll no topo da view
        tvPasswords.text = "" // limpa a view
        
        print("generatePasswordAgain")
        
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }
    }
    

}
