//
//  PhotoListVC.swift
//  Unsplash
//
//  Created by Rohit Saini on 16/04/21.
//

import UIKit

class PhotoListVC: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
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
        photoListVM.loadRandomPhoto(using: .shared)
        
        //Observing photos
        photoListVM.photosList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        //Observing random photos
        photoListVM.randomPicture.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
        tableView.register(UINib(nibName: TABLE_VIEW_CELL.PhotoCell.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.PhotoCell.rawValue)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_ :)), for: .valueChanged)
        refreshControl.tintColor = UIColor.AppColor
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
    }
    
    //MARK: - refreshData
    @objc func refreshData(_ sender: Any) {
        //loading initial photos
        photoListVM.loadPhotos(using: .shared)
        photoListVM.loadRandomPhoto(using: .shared)
    }

}

//MARK: - UITableView DataSource and Delegate Methods
extension PhotoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed(TABLE_VIEW_CELL.RandomPhotoCell.rawValue, owner: self, options: nil)?.first as? RandomPhotoCell else {
            return UIView()
        }
        headerView.randomPhoto.downloadCachedImage(placeholder: "", urlString: photoListVM.randomPicture.value?.urls?.small ?? "")
        return headerView
    }
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
        cell.picture.downloadCachedImage(placeholder: "", urlString: photoListVM.photosList.value[indexPath.row].urls?.thumb ?? "")
        cell.profilePic.downloadCachedImage(placeholder: "", urlString: photoListVM.photosList.value[indexPath.row].user?.profileImage?.small ?? "")
        return cell
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
}
