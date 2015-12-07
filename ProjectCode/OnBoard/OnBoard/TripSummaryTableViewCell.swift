//
//  TripSummaryTableViewCell.swift
//  OnBoard
//
//  Created by Johnson Pan on 2015-12-07.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class TripSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellIconImage: UIImageView!
    @IBOutlet weak var cellCatagoryLabel: UILabel!
    @IBOutlet weak var cellContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /************ Table ***************/
    func UpdateCell(cellItem : SummaryTableViewItem){
        cellIconImage.image = UIImage(named: cellItem.Icon)
        cellCatagoryLabel.text = cellItem.Catagory
        cellContentLabel.text = cellItem.Content
    }


}
