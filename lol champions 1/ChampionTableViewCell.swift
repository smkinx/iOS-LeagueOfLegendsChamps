//
//  ChampionTableViewCell.swift
//  lol champions 1
//
//  Created by Supratim Baruah on 11/30/14.
//  Copyright (c) 2014 Supratim Baruah. All rights reserved.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {

    @IBOutlet var champName: UILabel!
    @IBOutlet var champTitle: UILabel!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var champImage: UIImageView!
    @IBOutlet var seperatorImage: UIImageView!
    @IBOutlet var favBool: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
