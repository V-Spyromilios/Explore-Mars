//
//  Login View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI

struct Login_View: View {
	
	@EnvironmentObject var sessionManager: SessionManager
	@EnvironmentObject var viewModel: LoginViewModel
	@Environment(\.verticalSizeClass) private var verticalSizeClass
	@State private var loginIsValid = false
	@State private var registrationViewIsPresented = false
	@State var isRegistrationComplete = false
	
	var body: some View {
		NavigationView {
//			if sessionManager.isLoggedin {
//
//				TabBarView()
//			}
//			else {
				GeometryReader { geometry in
					VStack(spacing: 18) {
						
						Spacer().frame(height: getFirstSpacerHeight(with: geometry))
						
						LoginFieldsAndButtonView(email: $viewModel.email, password: $viewModel.password, loginIsValid: $loginIsValid, viewModel: viewModel)
						
						Spacer().frame(height: getSecondSpacerHeight(with: geometry))
						
						RegistrationLinkAndImageView(isRegistrationComplete: $isRegistrationComplete, loginIsValid: $loginIsValid)
							.padding(.horizontal)
							.frame(maxHeight: geometry.size.height * 0.15)
					}
				}
				.background(LoginbackgroundView())
				.navigationBarTitle("Explore Mars")
				.navigationBarTitleDisplayMode(.large)
				.onTapGesture {
					dismissKeyboard()
				}
			}
		}
	
	
	private func dismissKeyboard() {
		
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
	
	// .compact == true? ->  Landscape
	private func getFirstSpacerHeight(with geometry: GeometryProxy) -> CGFloat {
		
		return verticalSizeClass == .compact ? geometry.size.height * 0.08 : geometry.size.height * 0.11
	}
	
	private func getSecondSpacerHeight(with geometry: GeometryProxy) -> CGFloat {
		
		return verticalSizeClass == .compact ? geometry.size.height * 0.07 : geometry.size.height * 0.4
	}
}


struct Login_View_Previews: PreviewProvider {
	static var previews: some View {
		Login_View().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
	}
}

