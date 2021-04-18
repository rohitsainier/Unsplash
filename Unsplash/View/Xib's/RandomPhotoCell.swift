//
//  RandomPhotoCell.swift
//  Unsplash
//
//  Created by App Knit on 18/04/21.
//

import UIKit

class RandomPhotoCell: UITableViewCell {

    
    @IBOutlet weak var randomPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
