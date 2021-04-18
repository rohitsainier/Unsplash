//
//  PhotoDetailsVC.swift
//  Unsplash
//
//  Created by App Knit on 18/04/21.
//

import UIKit

class PhotoDetailsVC: UIViewController {

    //OUTLETS
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    private func configUI(){
        guard let photo = photo else{return}
        picture.downloadCachedImage(placeholder: PLACEHOLDER.placeholder.rawValue, urlString: photo.urls?.regular ?? DecodeDefaultValues.Empty.string)
        locationLbl.text = photo.user?.location
        profilePic.downloadCachedImage(placeholder: PLACEHOLDER.placeholder.rawValue, urlString: photo.user?.profileImage?.small ?? DecodeDefaultValues.Empty.string)
        usernameLbl.text = photo.user?.name
        descLbl.text = photo.photoDescription
    }
    
    //MARK:- clickCloseBtn
    @IBAction func clickCloseBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    

}
