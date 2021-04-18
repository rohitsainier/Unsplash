//
//  PhotoListViewModel.swift
//  Unsplash
//
//  Created by App Knit on 16/04/21.
//

import UIKit
import Foundation

protocol PhotoListDelegate {
    var photosList: Box<[Photo]> { get }
    var randomPicture: Box<Photo?> { get }
    func PhotoSize(index: IndexPath) -> CGFloat
    func loadPhotos(using session: URLSession)
    func loadRandomPhoto(using session: URLSession)
}

struct PhotoListViewModel:PhotoListDelegate{
    var randomPicture: Box<Photo?> = Box(nil)
    var photosList: Box<[Photo]> = Box([])
    
    //MARK:- PhotoSize
    //To Calculate Picture size
    func PhotoSize(index: IndexPath) -> CGFloat {
        return index.row % 2 == 0 ? (205) : (408)
    }
    
    //MARK: - loadPhotos
    func loadPhotos(using session: URLSession) {
        session.request(.photos, using: Void()) { (result) in
            switch result{
            case .success(let response):
                print(response)
                photosList.value = response
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func loadRandomPhoto(using session: URLSession) {
        session.request(.random, using: Void()) { (result) in
            switch result{
            case .success(let response):
                print(response)
                randomPicture.value = response
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
