//
//  Login Fields and Button View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 08.06.23.
//

import SwiftUI

struct LoginFieldsAndButtonView: View {

	@EnvironmentObject var sessionManager: SessionManager
	@Binding var email: String
	@Binding var password: String
	@Binding var loginIsValid: Bool
	@FocusState var emailIsFocused
	@FocusState var passwordIsFocused
	@ObservedObject var viewModel: LoginViewModel
	@State var loginAlertIsShowing = false
	@State private var loginError: Error?

	//TODO: Check if .padding(.leading) is ok
	var body: some View {
		VStack {
			TextField("", text: self.$viewModel.email, prompt: Text("email").foregroundColor(.white.opacity(0.6))).padding(.leading)
				.textFieldStyle(CustomTextFieldStyle())
				.textContentType(.emailAddress)
				.focused($emailIsFocused)
				.keyboardType(.emailAddress)
				.frame(height: 18)
				.padding(.all)
				.cornerRadius(10)
				.overlay(
					RoundedRectangle(cornerRadius: 7)
						.stroke(Color.white, lineWidth: 2)
						.opacity(0.7)).padding(.horizontal)
				.onReceive(viewModel.loginIsValid) { result in
					loginIsValid = result
				}
			
			SecureField("", text: self.$viewModel.password, prompt: Text("password").foregroundColor(.white.opacity(0.6)))
				.textFieldStyle(CustomTextFieldStyle())
				.focused($passwordIsFocused)
				.frame(height: 18)
				.padding(.all)
				.cornerRadius(10)
				.overlay(
					RoundedRectangle(cornerRadius: 7)
						.stroke(Color.white, lineWidth: 2)
						.opacity(0.7)).padding(.horizontal)
			Button("Log in", action: { print("Button Tapped.")
				sessionManager.signIn(withEmail: viewModel.email, password: viewModel.password) { result, error in
					if error != nil {
						loginError = error
						loginAlertIsShowing = true
					}
					else {
						sessionManager.isLoggedin = true
					}
				}
			})
			.frame(height: 18)
			.padding(.all)
			.disabled(loginIsValid ? false : true)
			.background {
				RoundedRectangle(cornerRadius: 7).fill(Color.blue)
			}.foregroundColor(.white)
				.opacity(loginIsValid  ? 1.0 : 0.5)
		}
		.alert(isPresented: $loginAlertIsShowing) {
			Alert(title: ((loginError != nil) ? Text("Login Failed"): Text("Successful Login")), message: ((loginError != nil) ? Text(loginError?.localizedDescription ?? "") : Text("You can now explore Mars")), dismissButton: .default(Text("OK")))
		}
	}
	
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

struct Login_Fields_and_Button_View_Previews: PreviewProvider {
	@State private var emailIsFocused = false
	@State private var passwordIsFocused = false
	
	static var previews: some View {
		LoginFieldsAndButtonView(email: .constant(""), password: .constant(""), loginIsValid: .constant(false), viewModel: LoginViewModel())
	}
}

