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
	@State var selectedSol = 0
	@StateObject var viewModel = MissionManifestViewModel()
	
	@State var sols: StrideThrough<Int>?
	
	var body: some View {
		
		ScrollView {
			Text("\(rover)".capitalized).font(.largeTitle).bold()
			List {
				Text("Mission Manifest").font(.title).bold()
					if let data = viewModel.data {
						
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
							.badge(data.manifest.status).bold()
						
						if let sols = sols {
							Picker(selection: $selectedSol, label: Text("Select Sol")) {
								ForEach(Array(sols), id: \.self) { sol in
									Text("\(sol)")
								}
							}
						}
					} else { Text("Data not available") }
			}.onAppear{ viewModel.fetchData(with: rover) }
				.frame(height: 360)
				.background(Color.white)
		}
	}
	
}

//struct RoverSolImagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoverSolImagesView()
//    }
//}
