//
//  AboutViewController.swift
//  Carangas
//
//  Created by Will Felix on 31/05/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gihub(sender: AnyObject) {
        self.openUrl("https://github.com/willfelix")
    }
    
    @IBAction func instagram(sender: AnyObject) {
        self.openUrl("https://www.instagram.com/willfelix0307/")
    }
    
    
    fileprivate func openUrl(_ str: String) {
        if let url = NSURL(string: str) {
            UIApplication.shared.openURL(url as URL)
        }
    }
}
