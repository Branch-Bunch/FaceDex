//
//  API.swift
//  FaceDex
//
//  Created by Jacky Chiu on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import Alamofire
import Argo

struct Links {
//	static let baseURL = "http://localhost:8080"
	static let baseURL = "https://face-dex.herokuapp.com"
}

public enum API: String {
	case enroll = "/enroll"
	case recognize = "/recognize"
	var url: String {
		return Links.baseURL + self.rawValue
	}
}
