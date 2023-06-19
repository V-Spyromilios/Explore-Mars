//
//  RoverSolImagesViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 19.06.23.
//

import Foundation
import Combine

final class MissionManifestApiService {
	
	var roverName: String
	@Published var receivedManifest: MissionManifest?
	private var cancellables = Set<AnyCancellable>()
	
	init(roverName: String) {
		self.roverName = roverName
		callApi()
	}
	
	private func callApi() {
		
		guard let apiKey = Configuration.apiKey else { return }
		guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/\(roverName)?&api_key=\(apiKey)") else { return }
		
		URLSession.shared.dataTaskPublisher(for: url)
//			.subscribe(on: DispatchQueue.global(qos: .background)) // dataTaskPublisher by default subs to background
			.receive(on: DispatchQueue.main) // no need to Dispatch.main in the 'receiveValue'
			.tryMap(handleOutput)
			.decode(type: MissionManifest.self, decoder: JSONDecoder())
			.sink { (completion)  in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("API Error: \(error)")
				}
			} receiveValue: { [weak self] receivedManifest in
				self?.receivedManifest = receivedManifest
			}
			.store(in: &cancellables)
	}
	
	private func handleOutput(output: URLSession.DataTaskPublisher.Output)throws -> Data {
		
		guard
			let response = output.response as? HTTPURLResponse,
			response.statusCode >= 200 && response.statusCode < 300 else { throw URLError(.badServerResponse) }
		
		return output.data
	}
	
}

final class MissionManifestViewModel: ObservableObject {
	@Published var data: MissionManifest?
	lazy var apiService = MissionManifestApiService(roverName: "")
	var cancellables = Set<AnyCancellable>()

	init() {}

	func fetchData(with name: String) {
		apiService = MissionManifestApiService(roverName: name)
		addSubscribers()
	}

	private func addSubscribers() {
		apiService.$receivedManifest
			.sink{ [weak self] manifest in
				guard let self = self else { return }
				self.data = manifest
			}.store(in: &cancellables)
	}
}
