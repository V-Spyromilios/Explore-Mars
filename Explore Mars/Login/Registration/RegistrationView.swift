//
//  RegistrationView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 06.06.23.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
	
	@ObservedObject private var viewModel = RegistrationViewModel()
	@Environment(\.verticalSizeClass) private var verticalSizeClass
	@Environment(\.presentationMode) private var presentationMode
	@FocusState private var emailIsFocused : Bool
	@FocusState private var passwordIsFocused : Bool
	@State private var registrationIsValid = false
	@Binding var isRegistrationComplete: Bool
	@State var registrationErrorIsShown: Bool = false
	
	var body: some View {
		
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
					.onReceive(viewModel.registrationIsValid) { result in
						self.registrationIsValid = result
					}
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.white, lineWidth: 2)
							.opacity(0.7)).padding(.horizontal)
				
				
				SecureField("", text: $viewModel.newPassword, prompt: Text("password").foregroundColor(.white.opacity(0.6)))
					.textFieldStyle(CustomTextFieldStyle())
					.focused($passwordIsFocused)
					.frame(height: 18)
					.padding(.all)
					.cornerRadius(10)
					.overlay(
						RoundedRectangle(cornerRadius: 10)
							.stroke(Color.white, lineWidth: 2)
							.opacity(0.7)).padding(.horizontal)
				
				
				Button("Continue", action: { print("Button Tapped.")
					Auth.auth().createUser(withEmail: $viewModel.newEmail.wrappedValue, password: $viewModel.newPassword.wrappedValue) { authResult, error in
						if error != nil {
							registrationErrorIsShown = true
						}
						else {
							isRegistrationComplete = true
							presentationMode.wrappedValue.dismiss()
						}
					}
				})
				.frame(height: 18)
				.padding(.all)
				.disabled(registrationIsValid ? false : true)
				.background {
					RoundedRectangle(cornerRadius: 10).fill(Color.blue)
				}.foregroundColor(.white)
					.opacity(registrationIsValid ? 1.0 : 0.5)
			}
			.alert(isPresented: $registrationErrorIsShown) {
				Alert(title: Text("Registration Failed"), message: Text("Please try again"), dismissButton: .default(Text("OK")))
			}
		}.background(registrationBackgroundView())
	}
	private func getFirstSpacerHeight(with geometry: GeometryProxy) -> CGFloat {
		
		return verticalSizeClass == .compact ? geometry.size.height * 0.08 : geometry.size.height * 0.11
	}
	//	private func dismissKeyboard() {
	//
	//		emailIsFocused = false
	//		passwordIsFocused = false
	//	}
	
	struct CustomTextFieldStyle: TextFieldStyle {
		func _body(configuration: TextField<Self._Label>) -> some View {
			configuration
				.foregroundColor(.white)
				.textInputAutocapitalization(.never)
				.font(.system(size: 16, weight: .regular).italic())
			//			.font(UIFont(name: <#T##String#>, size: <#T##CGFloat#>))
		}
	}
	
}

struct RegistrationView_Previews: PreviewProvider {
	static var previews: some View {
		RegistrationView(isRegistrationComplete: .constant(false), registrationErrorIsShown: false)
	}
}
