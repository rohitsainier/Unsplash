//
//  PhotoListVC.swift
//  Unsplash
//
//  Created by Rohit Saini on 16/04/21.
//

import UIKit

class PhotoListVC: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var photoListVM: PhotoListViewModel = PhotoListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
        
    }
    
    //MARK:- configUI
    private func configUI(){
        //loading initial photos
        photoListVM.loadPhotos(using: .shared)
        
        //Observing photos
        photoListVM.photosList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.register(UINib(nibName: TABLE_VIEW_CELL.PhotoCell.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.PhotoCell.rawValue)
    }

}

//MARK: - UITableView DataSource and Delegate Methods
extension PhotoListVC: UITableViewDelegate, UITableViewDataSource {
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return photoListVM.PhotoSize(index: indexPath)
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoListVM.photosList.value.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.PhotoCell.rawValue, for: indexPath) as? PhotoCell else { return UITableViewCell() }
        return cell
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
}