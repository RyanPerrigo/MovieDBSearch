//
//  ApiManager.swift
//  MovieBrowser
//
//  Created by Ryan Perrigo on 9/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation


class ApiManager {
	
	static let shared = ApiManager()
	
	func executeGetRequest(url:String, onCompletion:@escaping(Data)->Void) {
		
		if let url = URL(string: url) {
			
			let task = URLSession.shared.dataTask(with: url) { data, response, error  in
				if error != nil {
					print(error!.localizedDescription)
				} else {
					 onCompletion(data!)
				}
			}
			task.resume()
			}
		}

	
}
