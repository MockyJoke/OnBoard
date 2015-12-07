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
        userIconImage.image = UIImage(named: "skier")
        cellLabel.text = groupUser.Name
        if let activeData = groupUser.Data {
            
            if (self.groupUser!.IsYourself()){
                distanceLabel.text = "( Yourself )"
            }else{
                if let location = CoreLocationManager.sharedInstance.latestLocation{
                    let decimal = ".1"
                    distanceLabel.text = "\(groupUser.GetDistanceToCoordinate(location).format(decimal)) meters away"
                }else{
                    distanceLabel.text  = ""
                }
            }
            if (activeData.IsAbnormal()){
                userStatusIconImage.image = UIImage(named: "Warning")
            }else{
                userStatusIconImage.image = nil
            }
        }
    }
    
    func TapAction(){
        //print("The cell is clicked")
    }
}
