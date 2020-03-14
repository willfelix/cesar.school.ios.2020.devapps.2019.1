//
//  WorldCupViewController.swift
//  CampeoesCopas
//
//  Created by aluno on 29/02/20.
//  Copyright © 2020 Cesar School. All rights reserved.
//

import UIKit

class WorldCupViewController: UIViewController {

    var worldCup: WorldCup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = worldCup.winner
    }
    
    
    
}
