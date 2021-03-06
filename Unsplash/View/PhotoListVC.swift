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
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
        
    }
    
    //MARK:- configUI
    private func configUI(){
        //loading initial photos
        photoListVM.loadPhotos(using: .shared, page: page)
        photoListVM.loadRandomPhoto(using: .shared)
        
        //Observing photos
        photoListVM.photosList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.tableFooterView = nil
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
        //Registering cell
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
        refreshControl.attributedTitle = NSAttributedString(string: REFRESH_CONTROL.title.rawValue)
    }
    
    //MARK: - refreshData
    @objc func refreshData(_ sender: Any) {
        //loading initial photos
        page = 1
        photoListVM.photosList.value.removeAll()
        photoListVM.loadPhotos(using: .shared, page: page)
        photoListVM.loadRandomPhoto(using: .shared)
    }

}

//MARK: - UITableView DataSource and Delegate Methods
extension PhotoListVC: UITableViewDelegate, UITableViewDataSource {
    //heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    //viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed(TABLE_VIEW_CELL.RandomPhotoCell.rawValue, owner: self, options: nil)?.first as? RandomPhotoCell else {
            return UIView()
        }
        headerView.randomPhoto.downloadCachedImage(placeholder: PLACEHOLDER.placeholder.rawValue, urlString: photoListVM.randomPicture.value?.urls?.small ?? DecodeDefaultValues.Empty.string)
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
        cell.render(photo: photoListVM.photosList.value[indexPath.row])
        return cell
    }
    
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:PhotoDetailsVC = STORYBOARD.Main.load.instantiateViewController(withIdentifier: View_Controllers.PhotoDetailsVC.rawValue) as! PhotoDetailsVC
        vc.photo = photoListVM.photosList.value[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Load more items when we reach end of list
        if photoListVM.photosList.value.count - 1 == indexPath.row {
            page = page + 1
            photoListVM.loadPhotos(using: .shared, page: page)
            DispatchQueue.main.async {
                tableView.tableFooterView = self.spinnerFooter()
            }
        }
    }
    //MARK:- SpinnerFooter
    //Load more spinner
    private func spinnerFooter() -> UIView?{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView()
        spinner.color = UIColor.AppColor
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}
