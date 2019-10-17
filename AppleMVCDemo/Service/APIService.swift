//
//  APIService.swift
//  AppleMVCDemo
//
//  Created by Jason Chen on 2019/10/17.
//  Copyright © 2019 Jason Chen. All rights reserved.
//

import Foundation

//
// MARK: - APIService
//
// Runs query data task, and stores results in array of Photos
class APIService {
    // Simulate a long waiting for fetching
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: Error? ) -> () ) {
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try! decoder.decode(Photos.self, from: data)
            complete( true, photos.photos, nil )
        }
    }
}
