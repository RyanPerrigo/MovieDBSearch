//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
	
//	@IBOutlet weak var label: UILabel!
	
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	private var viewModel: MovieDetailViewModel?
	
	func setupWithVM(vm: MovieDetailViewModel) {
		viewModel = vm
	}
	
	override func viewDidLoad() {
		super .viewDidLoad()
		viewModel?.generateImageURL()
		viewModel?.upDateImageCallback = { data in
			DispatchQueue.main.async {
				self.imageView.image = UIImage(data: data)
				
			}
		}
		titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
		
		releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
		descriptionLabel.font = UIFont.systemFont(ofSize: 16)
		imageView.image = UIImage(named: "placeholder")
		titleLabel.text = viewModel?.mappedData.movieTitle
		releaseDateLabel.text = "Release Date: \(changeDateFormat(string: (viewModel?.mappedData.date)!))"
		descriptionLabel.text = viewModel?.mappedData.descriptionText
		

		imageView.clipsToBounds = true
		
	}
	
	func changeDateFormat(string:String) -> String{
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM dd, yyyy"
		
		if let theNewDate = formatter.date(from: string) {
			let secondIteration = DateFormatter()
			secondIteration.dateFormat = "MM/dd/yy"
			let returnDate = secondIteration.string(from: theNewDate)
			return returnDate
		} else {
			return "BAD DATE  CONVERSION"
		}
	}
	
	
	
	
}
