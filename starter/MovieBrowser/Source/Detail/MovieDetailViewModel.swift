//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class MovieDetailViewModel {
	var upDateImageCallback:((Data)->Void)?
	let mappedData: MovieOverviewCellModel
	private var imageURl: String = ""
	init(mappedData: MovieOverviewCellModel) {
		self.mappedData = mappedData
	}
	
	//"https://api.themoviedb.org/3/movie/11/images?api_key=5885c445eab51c7004916b9c0313e2d3&language=en"
	func generateImageURL() {
		let decoder = JSONDecoder()
		let getImageUrlString:String = "https://api.themoviedb.org/3/movie/\(mappedData.id)/images?api_key=\(Network.apiKey)&language=en"
		let baseImageURL: String = "https://image.tmdb.org/t/p/original/"
		ApiManager.shared.executeGetRequest(url: getImageUrlString) { Data in
			
			guard let safeResponseEntity = try? decoder.decode(ImagesResponseEntity.self, from: Data) else {print("CANNOT GET IMAGE DATA") ; return}
			print("SAFE RESPONSE ENTITY \(safeResponseEntity)")
			if let safePoster: PosterObject = safeResponseEntity.posters?[0] {
				guard let safeFilePath = safePoster.file_path else {print("CANNOT GET IMAGE FILE PATH") ; return}
				let newImageURL = baseImageURL + safeFilePath
				
				self.getMovieImage(urlString: newImageURL)
				
			}
			
		}
		
	}
	func getMovieImage(urlString: String){
		
		ApiManager.shared.executeGetRequest(url: urlString) { data in
			self.upDateImageCallback?(data)
		}
	}
		
		
		
	
}
