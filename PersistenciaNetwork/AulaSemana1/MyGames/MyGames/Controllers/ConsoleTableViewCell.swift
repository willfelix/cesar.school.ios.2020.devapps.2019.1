//
//  ConsoleTableViewCell.swift
//  MyGames
//
//  Created by Will Felix on 29/05/20.
//  Copyright © 2020 Douglas Frari. All rights reserved.
//

import UIKit

class ConsoleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbName: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func prepare(with console: Console) {
        lbName.text = console.name ?? ""
        if let image = console.cover as? UIImage {
            ivCover.image = image
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
    }

}
