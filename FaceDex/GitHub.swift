//
//  GitHub.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-05.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Curry
import Runes

struct GitHub {
	let handle: String
	let url: String
}

extension GitHub: Decodable {
	static func decode(_ json: JSON) -> Decoded<GitHub> {
		return curry(self.init)
		<^> json <| "handle"
		<*> json <| "url"
	}
}
