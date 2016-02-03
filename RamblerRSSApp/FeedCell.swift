//
//  FeedCell.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/3/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel! {
        didSet {
//            self.subtitleLabel.hidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
