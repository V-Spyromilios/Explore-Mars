//
//  MissionManifestModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 14.06.23.
//

import Foundation

struct MissionManifest: Decodable {
	
	var manifest: Manifest
	
	enum CodingKeys: String, CodingKey {
		
		case manifest = "photo_manifest"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.manifest = try container.decode(Manifest.self, forKey: .manifest)
	}
}


struct Manifest: Decodable {

	let name: String
	let launchingDate: String?
	let landingDate: String
	let status: String
	let totalSols: Int
	let maxDate: String
	let totalPhotos: Int

	enum CodingKeys: String, CodingKey {

		case name
		case status
		case launchingDate = "launch_date"
		case landingDate =  "landing_date"
		case totalSols = "max_sol"
		case maxDate = "max_date"
		case totalPhotos = "total_photos"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.launchingDate = try container.decode(String.self, forKey: .launchingDate)
		self.totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
		self.landingDate = try container.decode(String.self, forKey: .landingDate)
		self.totalSols = try container.decode(Int.self, forKey: .totalSols)
		self.maxDate = try container.decode(String.self, forKey: .maxDate)
		self.status = try container.decode(String.self, forKey: .status)
		self.name = try container.decode(String.self, forKey: .name)
	}
}
