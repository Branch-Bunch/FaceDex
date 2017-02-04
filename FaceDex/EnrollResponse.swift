//
//  EnrollResponse.swift
//  FaceDex
//
//  Created by Jacky Chiu on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Runes
import Curry

struct EnrollResponse {
	let success: Bool
	let error: String?
}

extension EnrollResponse: Decodable {
	static func decode(_ json: JSON) -> Decoded<EnrollResponse> {
		return curry(self.init)
			<^> json <| "success"
			<*> json <|? "error"
	}
}
