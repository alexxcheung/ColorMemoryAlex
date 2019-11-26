//
//  RankTableViewCell.swift
//  ColorMemory
//
//  Created by Alex Cheung on 26/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
