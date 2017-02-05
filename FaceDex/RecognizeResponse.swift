//
//  RecognizeResponse.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Runes
import Curry

struct RecognizeResponse {
	let persons: [Person]
	let error: String?
}

extension RecognizeResponse: Decodable {
	static func decode(_ json: JSON) -> Decoded<RecognizeResponse> {
		return curry(self.init)
		<^> json <|| "persons"
		<*> json <|? "error"
	}
}
