//
//  PhotoCell.swift
//  Unsplash
//
//  Created by App Knit on 17/04/21.
//

import UIKit

class PhotoCell: UITableViewCell {

    //OUTLETS
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
