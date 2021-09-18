//
//  ResponseEntity.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct ResultsObject:Codable{
	var poster_path: String?
	var adult: Bool?
	var overview: String?
	var release_date: String?
	var genre_ids: [Int]?
	var id: Int?
	var original_title: String?
	var original_language: String?
	var backdrop_path: String?
	var popularity: Float?
	var vote_count: Int?
	var video: Bool?
	var vote_average: Double?
	
}
struct ResponseEntity:Codable {
	var page: Int?
	var results: [ResultsObject]?
}
