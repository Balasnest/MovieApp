//
//  MovieModel.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 29/09/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import  UIKit

struct MovieData: Decodable {
    var results: [mainData]?
    var page: Int?
    var total_pages: Int?
    var dates:datesData?
}

struct mainData: Decodable {
    var vote_count:Int?
    var id: Int?
    var video: Bool?
    var vote_average: Float?
    var title: String?
    var popularity: Float?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
}

struct datesData: Decodable {
    var maximum: String?
    var minimum: String?
}
