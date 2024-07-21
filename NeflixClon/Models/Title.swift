//
//  Movie.swift
//  NeflixClon
//
//  Created by rom on 21/7/24.
//

import Foundation


struct TrendingTitleResponse : Codable{
    let results : [Title]
}


struct Title : Codable {
    let backdrop_path: String
    let id: Int
    let title, original_title, overview, poster_path: String?
    let media_type: String
    let adult: Bool
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
