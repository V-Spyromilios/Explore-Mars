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
	var pickedSol: Int
	@Published var receivedAlbum: RoverPhotos?
//	var cachedAlbums = [String: RoverPhotos]()
	private var cancellables = Set<AnyCancellable>()
	
	
	
	init(roverName: String, pickedSol: Int) {
		self.roverName = roverName
		self.pickedSol = pickedSol
		callPhotosApi()
	}
	
	private func callPhotosApi() {
		
//		if let cachedAlbum = self.cachedAlbums[roverName+String(pickedSol)] {
//			self.receivedAlbum = cachedAlbum
//			print("Photos from Cached.")
//			return
//		} else {
			
			guard let apiKey = Configuration.apiKey else { return }
			
			guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(roverName)/photos?api_key=\(apiKey)&sol=\(pickedSol)") else { return }
			print("Photos from API CALL.")
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
					
//					self?.cachedAlbums[(self?.roverName ?? "")+String(self?.pickedSol ?? -1)] = modifiableAlbum
					if !Thread.isMainThread {
						print("receivedAlbum on Background.")
						print("receivedAlbum: \(receivedAlbum.photos.first?.urlSource)")
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
	var apiService: RoverPhotosApiService? = nil
	var roverName: String?
	var selectedSol: Int?
	var cancellables = Set<AnyCancellable>()
	var isDataFetched = false
	
	init() {}
	
	func fetchData(with name: String, sol: Int = 0) {
		print("fetch Data called for \(name) and Sol: \(sol)")
		apiService = RoverPhotosApiService(roverName: name, pickedSol: sol)
		addSubscribers()
		
	}


private func addSubscribers() {
	apiService?.$receivedAlbum
		.sink{ [weak self] album in
			DispatchQueue.main.async { //as the .receive(on:) is off, to make the Dict in the background
				guard let self = self else { return }
				self.receivedAlbum = album
				self.isDataFetched = true
//				self.apiService?.cachedAlbums[(self.roverName ?? "")+String(self.selectedSol ?? -1)] = self.apiService?.receivedAlbum
			}
		}.store(in: &cancellables)
}
}

