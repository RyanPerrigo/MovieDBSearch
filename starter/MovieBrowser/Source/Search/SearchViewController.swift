//
//  SearchViewController.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/16/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate,UICollectionViewDelegateFlowLayout {
	
	@IBOutlet weak var shadedTextFieldHolderView: UIView!
	@IBOutlet weak var searchTextfield: UITextField!
	@IBOutlet weak var collectionView: UICollectionView!
	
	
	@IBAction func onGoTapped(_ sender: Any) {
		if let safeText = searchTextfield.text {
			viewmodel.onGoClicked(searchText:safeText)
		}
		
	}
	
	
	@IBOutlet weak var onGoClicked: UIButton!
	var getIndexPathCallback:(()->IndexPath)?
	private let layout = UICollectionViewFlowLayout()
	private let viewmodel:SearchViewControllerViewModel = {
		return SearchViewControllerViewModel()
	}()
	
	override func viewDidLoad() {
		
		
		self.collectionView.collectionViewLayout = layout
		super.viewDidLoad()
		self.title = "Movie Search"
		shadedTextFieldHolderView.layer.cornerRadius = 8
		searchTextfield.delegate = self
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellWithReuseIdentifier: "IDENT")
		viewmodel.updateViewCallback = {
			self.collectionView.reloadData()
		}
		viewmodel.navigateToMovieDetailCallback = {
			
			self.performSegue(withIdentifier: "movieDetailVCSegue", sender: self)
		}
		
	}
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let safeItem = self.viewmodel.getCellModelToPass() {
			
			let vc = segue.destination as? MovieDetailViewController
			vc?.setupWithVM(vm: MovieDetailViewModel(mappedData: safeItem))
			
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewmodel.getViewState().count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		self.getIndexPathCallback = {
			return indexPath
		}
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IDENT", for: indexPath)
		if let movieOverviewCell = cell as? MovieOverviewCell {
			movieOverviewCell.linkCellModel(model: viewmodel.getViewState()[indexPath.item])
			movieOverviewCell.bindLabelData(cellModel: viewmodel.getViewState()[indexPath.item])

			return movieOverviewCell
		}else {
			return cell
		}
	}
		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			let titleLabel = viewmodel.getViewState()[indexPath.item].movieTitle
			let estimatedFrame = NSString(string: titleLabel).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 100, height: 1000), options: .usesLineFragmentOrigin, attributes: [ .font : UIFont.boldSystemFont(ofSize: 20)], context: nil)
			return CGSize(width: UIScreen.main.bounds.width, height: estimatedFrame.height + 60)

		}
	
}





