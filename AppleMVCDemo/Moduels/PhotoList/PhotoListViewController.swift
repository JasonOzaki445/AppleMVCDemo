//
//  PhotoListViewController.swift
//  AppleMVCDemo
//
//  Created by Jason Chen on 2019/10/17.
//  Copyright © 2019 Jason Chen. All rights reserved.
//

import UIKit
import SDWebImage

//
// MARK: - Photo List View Controller
//
class PhotoListViewController: UIViewController {
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //
    // MARK: Variables And Properties
    //
    /// Array initialization of search results.
    var photos: [Photo] = [Photo]()
    /// Record the selected "IndexPath".
    var selectedIndexPath: IndexPath?
    /// Use the keyword "lazy" to wait for APIService's results.
    lazy var apiService: APIService = {
        return APIService()
    }()
    
    //
    // MARK: - View Controller's life cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Init the static view
        initView()
        
        // Fetch data from server
        initDate()
    }
    
    //
    // MARK: - Private Methods
    //
    // Init the static view
    func initView() {
        self.navigationItem.title = "Popular"
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Fetch data from server
    func initDate() {
        apiService.fetchPopularPhoto { [weak self] (success, photos, error) in
            DispatchQueue.main.async {
                self?.photos = photos
                self?.activityIndicator.stopAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                    self?.tableView.alpha = 1.0
                })
                
                self?.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
// MARK: - Table View Delegate & Table View Data Source
//
extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let photo = self.photos[indexPath.row]
        // Text
        cell.nameLabel.text = photo.name
        // Wrap a description
        var descText: [String] = [String]()
        if let camera = photo.camera {
            descText.append(camera)
        }
        
        if let description = photo.description {
            descText.append(description)
        }
        
        cell.descriptionLabel.text = descText.joined(separator: " - ")
        
        // Wrap the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.dateLabel.text = dateFormatter.string(from: photo.created_at)
        
        // Image
        cell.mainImageView.sd_setImage(with: URL(string: photo.image_url), completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let photo = self.photos[indexPath.row]
        if photo.for_sale { // If item is for sale
            self.selectedIndexPath = indexPath
            return indexPath
        } else {    // If item is not for sale
            let alert = UIAlertController(title: "Alert", message: "This item is not for sale", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return nil
        }
    }
}

//
// MARK: - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
extension PhotoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PhotoDetailViewController,
            let indexPath = self.selectedIndexPath {
            let photo = self.photos[indexPath.row]
            vc.imageUrl = photo.image_url
        }
    }
}

//
// MARK: - Photo List TableView Cell
//
class PhotoListTableViewCell: UITableViewCell {
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descContainerHeightConstraint: NSLayoutConstraint!
}
