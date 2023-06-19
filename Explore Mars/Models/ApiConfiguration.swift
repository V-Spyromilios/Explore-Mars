//
//  ApiConfiguration.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 12.06.23.
//

import Foundation

struct Configuration {
	static var apiKey: String? {
		guard let path = Bundle.main.path(forResource: "NasaApiKey", ofType: "plist"),
			  let config = NSDictionary(contentsOfFile: path),
			  let apiKey = config["API_KEY"] as? String
		else {
			return nil
		}
		return apiKey
	}
}
