//
//  RegistrationView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 06.06.23.
//

import SwiftUI

struct RegistrationView: View {
	
	@ObservedObject private var viewModel = RegistrationViewModel()
	@Environment(\.verticalSizeClass) private var verticalSizeClass
	@FocusState private var emailIsFocused : Bool
	@FocusState private var passwordIsFocused : Bool
	@State private var registrationIsValid = false
	
	var body: some View {
		
		onReceive(viewModel.registrationIsValid) { result in
			self.registrationIsValid = result
		}
		GeometryReader { geometry in
			VStack(spacing: 18) {
				Spacer()
					.frame(height: getFirstSpacerHeight(with: geometry))
				TextField("", text: $viewModel.newEmail, prompt: Text("email").foregroundColor(.white.opacity(0.6)))
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
				
				
				TextField("", text: $viewModel.newPassword, prompt: Text("password").foregroundColor(.white.opacity(0.6)))
					.textFieldStyle(CustomTextFieldStyle())
					.focused($passwordIsFocused)
					.frame(height: 18)
					.padding(.all)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.white, lineWidth: 2))
				
				
				Button("Continue", action: {})
					.frame(height: 18)
					.padding(.all)
					.opacity(registrationIsValid ? 1.0 : 0.7)
					.disabled(registrationIsValid ? false : true)
					.background {
						RoundedRectangle(cornerRadius: 10).fill(Color.blue)
					}.foregroundColor(.white)
			}
		}
	}
	
	private func getFirstSpacerHeight(with geometry: GeometryProxy) -> CGFloat {
		
		return verticalSizeClass == .compact ? geometry.size.height * 0.08 : geometry.size.height * 0.11
	}
	
	struct CustomTextFieldStyle: TextFieldStyle {
		func _body(configuration: TextField<Self._Label>) -> some View {
			configuration
				.foregroundColor(.white)
				.font(.system(size: 16, weight: .regular).italic())
			//			.font(UIFont(name: <#T##String#>, size: <#T##CGFloat#>))
		}
	}
	
}

struct RegistrationView_Previews: PreviewProvider {
	static var previews: some View {
		RegistrationView()
	}
}
