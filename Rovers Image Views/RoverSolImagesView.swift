//
//  RoverSolImagesView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 12.06.23.
//

import SwiftUI
import Combine

struct RoverSolImagesView: View {
	
	let rover: String
	@State private var selectedPhoto: RoverPhotos.Photo?
	@State var selectedSol = 0
	@StateObject var missionViewModel = MissionManifestViewModel()
	@State var sols: [Int] = []
	var totalSols: Int? {
		missionViewModel.data?.manifest.totalSols
	}
	@StateObject var photosViewModel = PhotosViewModel()
	
	var body: some View {
//		NavigationView {
			GeometryReader { geometry in
				ScrollView(showsIndicators: false) {
					VStack {
						HStack {
							Spacer()
							Text("\(rover)".capitalized)
								.font(.largeTitle)
								.bold()
							Spacer()
						} //Rover Name as largeTitle
						
						if let data = missionViewModel.data {
							VStack {
								DisclosureGroup("Mission Manifest") {
									List {
										Text("Launching Date")
											.badge(data.manifest.launchingDate)
										Text("Landing Date")
											.badge(data.manifest.landingDate)
										Text("Total Mars Days")
											.badge(data.manifest.totalSols)
										Text("Last Update")
											.badge(data.manifest.maxDate)
										Text("Total Photos")
											.badge(data.manifest.totalPhotos)
										Text("Mission Status")
											.badge(data.manifest.status)
									}.frame(minHeight: 360).listStyle(.grouped)
								} // the Manifest
								
								HStack {
									Text("Select Sol").foregroundColor(.blue)
									Spacer()
									Picker(selection: $selectedSol, label: EmptyView())  {
										ForEach(sols, id: \.self) { sol in
											Text("\(sol)")
										}
									}.pickerStyle(.automatic).padding(.trailing, -10)
								} // The Picker
							}.padding()
							
							LazyVStack {
								if let album = photosViewModel.receivedAlbum {
									ForEach(album.photosByCamera.keys.sorted(), id: \.self) { cameraName in //'key' in
										Section(header: HStack {
											Text(cameraName).font(.title3).bold().padding(.leading)
											Spacer()
										}) {
											ForEach(album.photosByCamera[cameraName] ?? [], id: \.id) { photo in
												
												NavigationLink(destination: PhotoDetailView(image: photo)) {
													AsyncImage(url: URL(string: photo.urlSource)) { image in
														image.resizable().aspectRatio(contentMode: .fill)
													} placeholder: {
														ProgressView()
													}.shadow(radius: 8.0)
													//												}
												}
												
											}
										}
									}
								} else { Text( "Loading...").padding() }
							} // Photos of the selectedSol
						} else { Text("Data not available").padding(.vertical) }
					}
				}
			}.onAppear{
				if !photosViewModel.isDataFetched {
					missionViewModel.fetchData(with: rover)
					photosViewModel.fetchData(with: rover, sol: selectedSol)
				}//by default argument sol = 0
			}
			.onChange(of: missionViewModel.data?.manifest.totalSols) { totalSols in
				if let totalSols = totalSols {
					sols = Array(0...totalSols)
				}
			}
			.onChange(of: selectedSol, perform: { sol in
				photosViewModel.isDataFetched = false
				photosViewModel.fetchData(with: rover, sol: selectedSol) }) //Override the default sol
		}
	
}


struct RoverSolImagesView_Previews: PreviewProvider {
	static var previews: some View {
		RoverSolImagesView(rover: "opportunity")
			.preferredColorScheme(.dark)
	}
}
