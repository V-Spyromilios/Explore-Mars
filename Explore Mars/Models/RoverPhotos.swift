//
//  RoverPhotos.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import Foundation

// Decodable Result when Quering with Rover name and sol :
//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=DEMO_KEY&sol=1000

struct RoverPhotos: Decodable {

	var photos = [Photo]()
	var photosByCamera: [String: [Photo]] = [:]

	enum CodingKeys: String, CodingKey {

		case photos
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.photos = try container.decode([Photo].self, forKey: .photos)
	}

	struct Photo: Decodable {

		let id: Int
		let sol: Int
		let camera: Camera
		let urlSource: String
		let dateTaken: String

		enum CodingKeys: String, CodingKey {

			case id
			case sol
			case camera
			case urlSource = "img_src"
			case dateTaken = "earth_date"
		}

		init(from decoder: Decoder) throws {

			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.id = try container.decode(Int.self, forKey: .id)
			self.sol = try container.decode(Int.self, forKey: .sol)
			let httpUrl = try container.decode(String.self, forKey: .urlSource)
			self.urlSource = httpUrl.replacingOccurrences(of: "http://", with: "https://")
			self.dateTaken = try container.decode(String.self, forKey: .dateTaken)
			self.camera = try container.decode(Camera.self, forKey: .camera)
		}

		init(demo: Bool = true) {
			self.id = 007
			self.sol = 1
			self.urlSource = "https://images-assets.nasa.gov/image/as11-40-5874/metadata.json"
			self.dateTaken = "20-06-2023"
			self.camera = Camera(demo: true)
		}
	}

	struct Camera: Decodable {

		let name: String
		let fullName: String
		//let roverId: Int

		enum CodingKeys: String, CodingKey {

			case name
			case fullName = "full_name"
			//case roverId = "rover_id"
		}

		init(from decoder: Decoder) throws {

			let container = try decoder.container(keyedBy: CodingKeys.self)
			self.name = try container.decode(String.self, forKey: .name)
			self.fullName = try container.decode(String.self, forKey: .fullName)
			//self.roverId = try container.decode(Int.self, forKey: .roverId)
		}

		init(demo: Bool = true) {
			self.fullName = "Front Cam Full Name"
			self.name = "FRONTHAZ_CAM"
		}
	}
}
