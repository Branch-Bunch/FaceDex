//
//  PersonResponse.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Runes
import Curry

struct PersonResponse {
	let success: Bool
	let persons: [Person]?
	let error: String?
}

extension PersonResponse: Decodable {
	static func decode(_ json: JSON) -> Decoded<PersonResponse> {
		return curry(self.init)
		<^> json <| "sccuess"
		<*> json <||? "persons"
		<*> json <|? "error"
	}
}