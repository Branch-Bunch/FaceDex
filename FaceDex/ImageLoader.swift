//
//  ImageLoader.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-05.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit

struct ImageLoader {
	static func fetch(url: String, completion: @escaping (Data) -> ()) {
		guard let imageURL = URL(string: url) else { return }
		let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { data, reponse, error in
			guard let data = data else { return }
			DispatchQueue.main.async {
				completion(data)
			}
		})
		task.resume()
	}
}
