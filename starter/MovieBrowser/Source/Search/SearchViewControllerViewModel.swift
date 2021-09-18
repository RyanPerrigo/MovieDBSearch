//
//  SearchViewControllerViewModel.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/16/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class SearchViewControllerViewModel {
	private var viewState: [MovieOverviewCellModel] = []
	
	var navigateToMovieDetailCallback: (()->Void)?
	var updateViewCallback:(()->Void)?
	private var cellClickedState: MovieOverviewCellModel?
	
	func onGoClicked(searchText: String) {
		if let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
			let url = "https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3&query=\(encodedText)"
			print(searchText)
			ApiManager.shared.getMovieInfo(url: url) { data in
				
				self.mapResponseData(data: data) { cellModels in
					self.viewState = cellModels
				}
				
			}
			self.updateViewCallback?()
		}
		
	}
	func mapResponseData(data:Data, onCompletion:@escaping([MovieOverviewCellModel])->Void) {
		let decoder = JSONDecoder()
		
		guard let safeData = try? decoder.decode(ResponseEntity.self, from: data) else {print("Error Getting Data");return}
		if let safeResults = safeData.results {
			let cellModels:[MovieOverviewCellModel] = safeResults.compactMap { ResultsObject in
				
			let title = ResultsObject.original_title ?? "CANNOT GET MOVIE TITLE"
				let releaseDate = ResultsObject.release_date ?? "NO RELEASE DATE DATA"
				let rating = ResultsObject.vote_average?.description ?? "noVoteAverage"
				let descriptionText = ResultsObject.overview ?? "NO OVERVIEW AVAILABLE"
				let movieID = ResultsObject.id ?? 0
				return MovieOverviewCellModel(movieTitle: title,
					date: changeDateFormat(string: releaseDate),
					rating: rating, descriptionText: descriptionText, id: movieID, onCellTappedCallback: { cellModel in
						self.cellClickedState = cellModel
						self.navigateToMovieDetailCallback?()
					})
			}
			onCompletion(cellModels)
		}
	}
	func changeDateFormat(string:String) -> String{
		let formatter = DateFormatter()
		formatter.dateFormat = "yy-MM-dd"
		
		if let theNewDate = formatter.date(from: string) {
			let secondIteration = DateFormatter()
			secondIteration.dateFormat = "MMMM dd, yyyy"
			let returnDate = secondIteration.string(from: theNewDate)
			return returnDate
		} else {
			return "BAD DATE  CONVERSION"
		}
	}
	func getCellModelToPass() -> MovieOverviewCellModel? {
		
		if let safeState = cellClickedState {
			return safeState
		} else {
			return nil
		}
	}
	func getViewState() -> [MovieOverviewCellModel] {
		return viewState
	}
		
}
