//
//  FaceViewModel.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Foundation

protocol FaceModelDelegate: class {
	func responseReturned()
}

struct FaceViewModel {
	var persons: [Person]
	var imageData: Data?
	weak var delegate: FaceModelDelegate?

	func recognize() {
		API.recognizeFace(imageData: self.imageData!)
		// do delegate message
	}
}
