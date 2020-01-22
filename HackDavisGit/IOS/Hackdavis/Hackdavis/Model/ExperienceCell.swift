//
//  ExperienceCell.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {
    
 
    @IBOutlet weak var expLabel: UILabel!
    
    @IBOutlet weak var expLabelShadow: UILabel!
    
    var expList = ["Outdoors","Arts and Crafts", "Culinary","Mentorship and Teaching", "Fundraising", "Caregiving", "Music", "Adverising"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
