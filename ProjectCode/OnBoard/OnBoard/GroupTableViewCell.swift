//
//  GroupTableViewCell.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/29/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
