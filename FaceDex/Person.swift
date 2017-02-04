//
//  Person.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Argo
import Curry
import Runes

struct Person {
	let name: String
	let link: String?
}

extension Person: Decodable {
	static func decode(_ json: JSON) -> Decoded<Person> {
		return curry(self.init)
		<^> json <| "name"
		<*> json <|? "url"
	}
}

