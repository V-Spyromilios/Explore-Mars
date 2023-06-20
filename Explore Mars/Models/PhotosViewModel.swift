//
//  PhotosViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 20.06.23.
//

import Foundation
import Combine

final class RoverPhotosApiService {
	
	var roverName: String = ""
	var pickedSol: Int = 0
	@Published var receivedAlbum: RoverPhotos?
	private var cancellables = Set<AnyCancellable>()
	
	init(roverName: String, pickedSol: Int) {
		self.roverName = roverName
		callPhotosApi()
	}
	
	private func callPhotosApi() {
		
		guard let apiKey = Configuration.apiKey else { return }
		guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=\(apiKey)&sol=\(pickedSol)") else { return }
		
		URLSession.shared.dataTaskPublisher(for: url)
//			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: RoverPhotos.self, decoder: JSONDecoder())
			.sink { (completion)  in
				switch completion {
				case .finished:
					print("Photos Completion: \(completion)")
					break
				case .failure(let error):
					print("API Error: \(error)")
				}
			} receiveValue: { [weak self]  receivedAlbum in
				var modifiableAlbum = receivedAlbum // mutable copy, 'receivedAlbum' is let
				
				modifiableAlbum.photos.sort { $0.camera.name < $1.camera.name }
				modifiableAlbum.photosByCamera = Dictionary(grouping: modifiableAlbum.photos) { $0.camera.name }
				self?.receivedAlbum = modifiableAlbum
				if !Thread.isMainThread {
					print("receivedAlbum on Background.")
				}
				
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

final class PhotosViewModel: ObservableObject {
	@Published var receivedAlbum: RoverPhotos?
	var apiService: RoverPhotosApiService?
	var cancellables = Set<AnyCancellable>()
	
	init() {}
	
	func fetchData(with name: String, sol: Int = 0) {
		print("fetch Data called.")
		apiService = RoverPhotosApiService(roverName: name, pickedSol: sol)
		addSubscribers()
		
	}
	
	private func addSubscribers() {
		apiService?.$receivedAlbum
			.sink{ [weak self] album in
				DispatchQueue.main.async { //as the .receive(on:) is off, to make the Dict in the background
					guard let self = self else { return }
					self.receivedAlbum = album
				}
			}.store(in: &cancellables)
	}
}
