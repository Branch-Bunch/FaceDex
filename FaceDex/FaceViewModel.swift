//
//  FaceViewModel.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Alamofire
import Argo

protocol FaceModelDelegate: class {
	func enrollResponse()
	func recognizeResponse()
	func errorResponse()
}

class FaceViewModel {
	var persons: [Person] = []
	var imageData: Data?
	weak var delegate: FaceModelDelegate?
	
	init(imageData: Data?) {
		self.imageData = imageData
	}

	func enrollFace(name: String) {
		guard let imageData = imageData else { return }
		let params: Parameters = [
			"name": name,
			"image": imageData.base64EncodedString()
		]
		
		Alamofire.request(API.enroll.url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
			debugPrint(response)
		}
	}
	
	func recognizeFace() {
		guard let imageData = imageData else { return }
		let params: Parameters = [
			"image": imageData.base64EncodedString()
		]
		
		Alamofire.request(API.recognize.url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
			debugPrint(response)
			if let value = response.result.value, let recognizeResponse: RecognizeResponse = decode(value) {
				self.persons = recognizeResponse.persons
			}
		}
	}
}
