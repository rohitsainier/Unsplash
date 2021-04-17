//
//  AppEnum.swift
//  Unsplash
//
//  Created by App Knit on 17/04/21.
//

import Foundation

//MARK:- TABLE_VIEW_CELL
enum TABLE_VIEW_CELL:String{
    case PhotoCell
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
