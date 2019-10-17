//
//  PhotoDetailViewController.swift
//  AppleMVCDemo
//
//  Created by Jason Chen on 2019/10/17.
//  Copyright © 2019 Jason Chen. All rights reserved.
//

import UIKit
import SDWebImage

//
// MARK: - Photo Detail View Controller
//
class PhotoDetailViewController: UIViewController {

    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var imageView: UIImageView!
    
    //
    // MARK: Variables And Properties
    //
    /// The URL of image
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, type, url) in
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
