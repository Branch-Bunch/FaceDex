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
	func enrollResponse(enrollResponse: EnrollResponse)
	func recognizeResponse()
	func errorResponse(message: String)
	func updatedImageAt(index: Int)
}

class FaceViewModel {
	var persons: [Person] = []
	var profiles: [Data?] = []
	var imageData: Data?
	weak var delegate: FaceModelDelegate?
	
	init(imageData: Data?) {
		self.imageData = imageData
	}

	func enrollFace(name: String, github: String) {
		guard let imageData = imageData else { return }
		let params: Parameters = [
			"name": name,
			"github": github,
			"image": imageData.base64EncodedString()
		]
		
		Alamofire.request(API.enroll.url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
			debugPrint(response)
			if let value = response.result.value, let enrollResponse: EnrollResponse = decode(value) {
				self.delegate?.enrollResponse(enrollResponse: enrollResponse)
			}
		}
	}
	
	func recognizeFace() {
		guard let imageData = imageData else { return }
		let params: Parameters = [
			"image": imageData.base64EncodedString()
		]
		
		Alamofire.request(API.recognize.url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
			debugPrint(response)
			if response.result.isSuccess {
				if let value = response.result.value, let recognizeResponse: RecognizeResponse = decode(value) {
					if let error = recognizeResponse.error {
						self.delegate?.errorResponse(message: error)
					} else {
						self.persons = recognizeResponse.persons
						self.profiles = Array<Data?>(repeating: nil, count: self.persons.count)
						self.delegate?.recognizeResponse()
						self.getImages()
					}
				}
			} else {
				self.delegate?.errorResponse(message: "API Broke")
			}
		}
	}

	func getImages() {
		for (index, person) in self.persons.enumerated() {
			guard let url = person.link else { return }
			ImageLoader.fetch(url: url + ".png") { data in
				self.profiles[index] = data
				self.delegate?.updatedImageAt(index: index)
			}
		}
	}
}
