//
//  Login View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI

struct Login_View: View {
	
	@ObservedObject private var viewModel = User()
	@Environment(\.verticalSizeClass) private var verticalSizeClass
	@FocusState private var emailIsFocused : Bool
	@FocusState private var passwordIsFocused : Bool // FocusState does not take arguments!!
	@State private var loginIsValid = false
	@State private var registrationViewIsPresented = false

	var body: some View {

		GeometryReader { geometry in

			VStack(spacing: 18) {
				Spacer()
					.frame(height: getFirstSpacerHeight(with: geometry))
				TextField("", text: self.$viewModel.email, prompt: Text("email").foregroundColor(.white.opacity(0.6)))
					.textFieldStyle(CustomTextFieldStyle())
					.textContentType(.emailAddress)
					.focused($emailIsFocused)
					.keyboardType(.emailAddress)
					.frame(height: 18)
					.padding(.all)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.white, lineWidth: 2))
					.onReceive(viewModel.loginIsValid) { result in
						loginIsValid = result
		   }
					

				TextField("", text: self.$viewModel.password, prompt: Text("password").foregroundColor(.white.opacity(0.6)))
					.textFieldStyle(CustomTextFieldStyle())
					.focused($passwordIsFocused)
					.frame(height: 18)
					.padding(.all)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.white, lineWidth: 2))
					
					
				Spacer()
					.frame(height: getSecondSpacerHeight(with: geometry))
				HStack(alignment: .center) {
					Button(action: { registrationViewIsPresented.toggle() }) { Text("Don't have an account?")}

					Spacer()
					Image("nasa-logo")
						.resizable()
						.frame(width: getImageDiamensions(with: geometry), height: getImageDiamensions(with: geometry))
				}
				.frame(maxHeight: geometry.size.height * 0.15)
			}.sheet(isPresented: $registrationViewIsPresented) {
				RegistrationView()
		 }
			.onTapGesture {
				dismissKeyboard()
			}.padding(.horizontal)
		}
		.background(LoginbackgroundView())
	}
	
	
	func dismissKeyboard() {

		emailIsFocused = false
		passwordIsFocused = false
		
	}

	// .compact == true ->  Landscape
	private func getSecondSpacerHeight(with geometry: GeometryProxy) -> CGFloat {
		
		return verticalSizeClass == .compact ? geometry.size.height * 0.35 : geometry.size.height * 0.55
	}

	private func getImageDiamensions(with geometry: GeometryProxy) -> CGFloat {

		return verticalSizeClass == .compact ? geometry.size.width * 0.1 : geometry.size.width * 0.2
	}

	private func getFirstSpacerHeight(with geometry: GeometryProxy) -> CGFloat {

		return verticalSizeClass == .compact ? geometry.size.height * 0.08 : geometry.size.height * 0.11
	}
}

struct CustomTextFieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.foregroundColor(.white)
			.font(.system(size: 16, weight: .regular).italic())
//			.font(UIFont(name: <#T##String#>, size: <#T##CGFloat#>))
	}
}

struct Login_View_Previews: PreviewProvider {
	static var previews: some View {
		Login_View().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
	}
}
 
