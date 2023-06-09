//
//  PickRoverView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 09.06.23.
//

import SwiftUI

struct PickRoverView: View {
	var body: some View {
		GeometryReader { geometry in
			List {
				Button(action: { print("1 button was tapped")}) {
					Image("spirit")
						.resizable()
						.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
						.aspectRatio(contentMode: .fill)
				}.buttonStyle(.plain)
					.listRowSeparator(.hidden)
				Button(action: { print("2 button was tapped")}) {
					Image("opportunity")
						.resizable()
						.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
						.aspectRatio(contentMode: .fill)
				}
				.buttonStyle(.plain)
							.listRowSeparator(.hidden)
				Button(action: { print("3 button was tapped")}) {
					Image("curiosity")
						.resizable()
						.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
						.aspectRatio(contentMode: .fill)
				}
				.buttonStyle(.plain)
							.listRowSeparator(.hidden)
				Button(action: { print("4 button was tapped")}) {
					Image("perseverance")
						.resizable()
						.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
						.aspectRatio(contentMode: .fill)
				}
				.buttonStyle(.plain)
							.listRowSeparator(.hidden)
			}.listStyle(PlainListStyle())
			
		}
	}
}
struct PickRoverView_Previews: PreviewProvider {
	static var previews: some View {
		PickRoverView()
	}
}
