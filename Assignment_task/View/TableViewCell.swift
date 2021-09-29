//
//  TableViewCell.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import UIKit

class TableViewCell: UITableViewCell{
   
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var candidateName: UILabel!
    
    @IBOutlet weak var candidateAge: UILabel!
    
    @IBOutlet weak var candidateGender: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

}

