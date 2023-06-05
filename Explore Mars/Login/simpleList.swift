//
//  simpleList.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 02.06.23.
//

import SwiftUI

struct simpleList: View {
	
	struct singleElement: Identifiable, Hashable {
		let element: String
		let id = UUID()
	}
	
	
	private var contents = [
		singleElement(element: "0"),
		singleElement(element: "1"),
		singleElement(element: "2"),
		singleElement(element: "3"),
		singleElement(element: "4")
	]
	@State private var multiSelection = Set<UUID>()
	
	
	var body: some View {
		NavigationView {
			VStack {
				List(contents, selection: $multiSelection) {
					Text($0.element)
				}
				.navigationTitle("Evangeloθ")
				.toolbar { EditButton() }
				Text("Selected IDs: \(selectedIDsString())")
					.font(.caption)
				
			}
		}.background(Image("Airfield"))
	}
	private func selectedIDsString() -> String {
		let selectedIDs = multiSelection.map { $0.uuidString }
		return selectedIDs.joined(separator: ", ")
	}
//	private func selectedIDsString() -> String {
//			let selectedItems = contents.filter { multiSelection.contains($0.id) }
//			let selectedIDs = selectedItems.map { $0.element }
//			return selectedIDs.joined(separator: ", ")
//		}
//
	
	struct simpleList_Previews: PreviewProvider {
		static var previews: some View {
			simpleList()
		}
	}
}
