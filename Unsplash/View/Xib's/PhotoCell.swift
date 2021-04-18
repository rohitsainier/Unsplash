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
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configUI(){
        profilePic.layer.borderWidth = 2
        profilePic.layer.borderColor = UIColor.white.cgColor
    }
    
}
