//
//  TabBar View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 09.06.23.
//

import SwiftUI

struct TabBarView: View {

	@ObservedObject var viewModel: LoginViewModel
	@State private var selectedTab: Tab = .images
	enum Tab {
			case images
			case more
		}

	var body: some View {
		TabView {
			PickRoverView()
			.tabItem {
				Image(systemName: "photo.stack.fill").renderingMode(.original)
				Text("Images")
			}.tag(Tab.images)
			LogoutView(viewModel: viewModel)
			.tabItem {
				Image(systemName: "ellipsis.rectangle.fill").renderingMode(.original)
				Text("More")
			}.tag(Tab.more)
		}
	}
}

struct TabBar_View_Previews: PreviewProvider {
    static var previews: some View {
		TabBarView(viewModel: LoginViewModel())
    }
}

extension View {
	func tabBarModifier<SelectionValue>(selection: Binding<SelectionValue>) -> some View where SelectionValue : Hashable {
		self
			.accentColor(.red) // Change the accent color of the tab bar
			.tabViewStyle(DefaultTabViewStyle()) // Change the tab bar style
			.onChange(of: selection.wrappedValue) { _ in
				UIImpactFeedbackGenerator(style: .light).impactOccurred() // Provide haptic feedback when switching tabs
			}
	}
}
