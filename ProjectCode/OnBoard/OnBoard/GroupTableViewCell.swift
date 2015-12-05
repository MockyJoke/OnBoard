//
//  GroupTableViewCell.swift
//  OnBoard
//
//  Created by Johnson Pan on 11/29/15.
//  Copyright (c) 2015 Rainbow Riders. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    var groupUser : GroupUser?
    @IBOutlet weak var userIconImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var userStatusIconImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateCell(groupUser : GroupUser){
        self.groupUser = groupUser
        userIconImage.image = UIImage(named: "User_blue")
        cellLabel.text = groupUser.Name
        if let activeData = groupUser.Data {
            if (activeData.StatusCode == "0"){
                userStatusIconImage.image = UIImage(named: "Warning")
            }else{
                userStatusIconImage.image = nil
            }
            distanceLabel.text = "0 meters away"
        }
    }
    
    func TapAction(){
        print("The cell is clicked")
    }
}
