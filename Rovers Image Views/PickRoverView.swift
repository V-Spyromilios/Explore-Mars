//
//  PickRoverView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 09.06.23.
//

import SwiftUI

struct PickRoverView: View {

	@State private var scrollViewContentOffset: CGFloat = .zero
	let rovers = ["spirit","opportunity", "curiosity", "perseverance"]

	var body: some View {
		
		GeometryReader { geometry in
			ScrollView(showsIndicators: false) {
				VStack {
					ForEach(rovers, id: \.self) { rover in
						NavigationLink(destination: RoverSolImagesView(rover: rover)) {
							ResizableImage(image: Image("\(rover)"), geometry: geometry, name: rover)
						}
					}
				}
			}
		}
	}
}

struct ResizableImage: View {
	let image: Image
	let geometry: GeometryProxy
	let name: String
	
	var body: some View {
		image
			.resizable()
			.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
			.aspectRatio(contentMode: .fill)
			.rotation3DEffect(.degrees(name == "spirit" ? 180: 0), axis: (x: 0, y: 1, z: 0))
	}
}


struct PickRoverView_Previews: PreviewProvider {
	static var previews: some View {
		PickRoverView()
	}
}
