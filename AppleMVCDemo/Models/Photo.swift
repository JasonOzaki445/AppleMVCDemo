//
//  Photo.swift
//  AppleMVCDemo
//
//  Created by Jason Chen on 2019/10/17.
//  Copyright © 2019 Jason Chen. All rights reserved.
//

import Foundation

//
// MARK: - Photos
//
// Query service creates Photos objects
struct Photos: Codable {
    //
    // MARK: - Constants
    //
    let photos: [Photo]
}

//
// MARK: - Photo
//
// Query service creates Photo objects
struct Photo: Codable {
    //
    // MARK: - Constants
    //
    let id: Int
    let name: String
    let description: String?
    let created_at: Date
    let image_url: String
    let for_sale: Bool
    let camera: String?
}
