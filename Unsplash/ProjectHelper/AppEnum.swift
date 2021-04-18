//
//  AppEnum.swift
//  Unsplash
//
//  Created by App Knit on 17/04/21.
//

import Foundation
import UIKit

//MARK:- STORYBOARD
enum STORYBOARD{
    case Main
    var load: UIStoryboard{
        switch self {
        case .Main:
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}

//MARK:- View_Controllers
enum View_Controllers:String{
    case PhotoListVC,PhotoDetailsVC
}

//MARK:- TABLE_VIEW_CELL
enum TABLE_VIEW_CELL:String{
    case PhotoCell,RandomPhotoCell
}

//MARK:- FOOTER
enum FOOTER:String{
    case title = "Loading more photos..."
}

//MARK:- REFRESH_CONTROL
enum REFRESH_CONTROL:String{
    case title = "Refreshing..."
}

//MARK:- DocumentDefaultValues
struct DecodeDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}




