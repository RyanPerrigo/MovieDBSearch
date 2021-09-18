//
//  MovieOverviewCell.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieOverviewCell: UICollectionViewCell {
	@IBOutlet weak var topLevelView: UIView!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var ratingLabel: UILabel!
	private var cellModel: MovieOverviewCellModel?
	@IBOutlet weak var movieTitleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		dateLabel.textColor = .systemGray4
		dateLabel.font = dateLabel.font.withSize(12)
        // Initialization code
		movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
		movieTitleLabel.text = "STAR WARS: RISE OF THE RISTANCE IN SOME FASHION"
		let tap = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
		topLevelView.addGestureRecognizer(tap)
		
    }
	@objc func onViewTapped() {
		print("ViewTapped")
		if let safeModel = cellModel {
			safeModel.onCellTappedCallback?(MovieOverviewCellModel(movieTitle: safeModel.movieTitle, date: safeModel.date, rating: safeModel.rating, descriptionText: safeModel.descriptionText, id: safeModel.id, onCellTappedCallback: nil))
		}
		
	}
	func getCellheight() -> CGFloat {		return movieTitleLabel.bounds.height
	}
	func bindLabelData(cellModel: MovieOverviewCellModel) {
		movieTitleLabel.text = cellModel.movieTitle
		dateLabel.text = cellModel.date
		ratingLabel.text = cellModel.rating
	}
	func linkCellModel(model: MovieOverviewCellModel){
		self.cellModel = model
	}
	func getLabelHeight() -> CGFloat {
		return movieTitleLabel.bounds.height
	}
}

struct MovieOverviewCellModel {
	let movieTitle: String
	let date: String
	let rating: String
	let descriptionText: String
	let id: Int
	var onCellTappedCallback:((MovieOverviewCellModel)->Void)?
	
	
}
