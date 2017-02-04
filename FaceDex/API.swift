//
//  API.swift
//  FaceDex
//
//  Created by Jacky Chiu on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit
import Alamofire

struct API {
	static let baseURL = "http://http://face-dex.herokuapp.com"
	
	static func enrollFace(imageData: Data, name: String) {
		let params: Parameters = [
			"name": name,
			"image": imageData.base64EncodedString()
		]
		
		Alamofire.request("\(baseURL)/enroll", method: .post, parameters: params).responseJSON { res in
			print(res.data ?? "no work")
		}
	}
	
	static func recognizeFace(imageData: Data) {
			let params: Parameters = [
				"image": imageData.base64EncodedString()
			]

			Alamofire.request("\(baseURL)/enroll", method: .post, parameters: params).responseJSON { res in
				print(res.data ?? "no work")
			}
	}
}
