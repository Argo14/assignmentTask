//
//  ExperienceTableViewCell.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var experienceLabel: UILabel!
    
    @IBOutlet weak var organizationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
