//
//  Utility.swift
//  Unsplash
//
//  Created by App Knit on 17/04/21.
//

import UIKit
import SDWebImage

//MARK:- RoundedImageView
class RoundedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        assert(bounds.height == bounds.width, "The aspect ratio isn't 1/1. You can never round this image view!")
        
        layer.cornerRadius = bounds.height / 2
    }
}


//MARK: - UIImageView
extension UIImageView{
    //MARK: - downloadCachedImage
    func downloadCachedImage(placeholder: String,urlString: String){
        //Progressive Download
        //This flag enables progressive download, the image is displayed progressively during download as a browser would do. By default, the image is only displayed once completely downloaded.
        //so this flag provide a better experience to end user
        let options: SDWebImageOptions = [.progressiveDownload,.scaleDownLargeImages]
        let placeholder = UIImage(named: placeholder)
        DispatchQueue.global().async {
            self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType,_ ) in
                guard image != nil else {
                    return
                }
                //Loading cache images for better and fast performace
                guard cacheType != .memory, cacheType != .disk else {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }
    }
}

//MARK:- AppColor
extension UIColor {
    static var AppColor: UIColor  { return UIColor(red: 129/255, green: 213/255, blue: 216/255, alpha: 1) }
}
