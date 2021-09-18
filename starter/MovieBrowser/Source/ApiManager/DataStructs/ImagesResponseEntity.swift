//
//  ImagesResponseEntity.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct PosterObject: Codable {
	var file_path: String?
}

struct ImagesResponseEntity: Codable {
	var posters: [PosterObject]?
}
