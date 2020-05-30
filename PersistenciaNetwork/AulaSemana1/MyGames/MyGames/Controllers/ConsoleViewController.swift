//
//  ConsoleViewController.swift
//  MyGames
//
//  Created by Will Felix on 29/05/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

class ConsoleViewController: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var console: Console?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        lbName.text = console?.name
        if let image = console?.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! AddEditConsoleViewController
        vc.console = console
    }

}
