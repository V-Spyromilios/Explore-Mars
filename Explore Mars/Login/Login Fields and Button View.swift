//
//  Login Fields and Button View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 08.06.23.
//

import SwiftUI

struct LoginFieldsAndButtonView: View {
	
	@Binding var email: String
	@Binding var password: String
	@FocusState var emailIsFocused : Bool
	@FocusState var passwordIsFocused : Bool
	@Binding var loginIsValid: Bool
	@ObservedObject var viewModel: LoginViewModel
	
	var body: some View {
		VStack {
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
						.stroke(Color.white, lineWidth: 2)
						.opacity(0.7)).padding(.horizontal)
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
						.stroke(Color.white, lineWidth: 2)
						.opacity(0.7)).padding(.horizontal)
			Button("Log in", action: { print("Button Tapped.")
				viewModel.signIn(withEmail: viewModel.email, password: viewModel.password) { result in
					if result == true {
						//show tabbar
					}
					else {
						return //show Login Error Warning
					}
				}
			})
			.frame(height: 18)
			.padding(.all)
			.disabled(loginIsValid ? false : true)
			.background {
				RoundedRectangle(cornerRadius: 10).fill(Color.blue)
			}.foregroundColor(.white)
				.opacity(loginIsValid  ? 1.0 : 0.5)
		}.onTapGesture {
			dismissKeyboard()
		}
	}
		
		func dismissKeyboard() {
			
			emailIsFocused = false
			passwordIsFocused = false
			
		}
	
	struct CustomTextFieldStyle: TextFieldStyle {
		func _body(configuration: TextField<Self._Label>) -> some View {
			configuration
				.foregroundColor(.white)
				.font(.system(size: 16, weight: .regular).italic())
			//			.font(UIFont(name: <#T##String#>, size: <#T##CGFloat#>))
		}
	}
	
	struct Login_Fields_and_Button_View_Previews: PreviewProvider {
		static var previews: some View {
			LoginFieldsAndButtonView(email: .constant(""), password: .constant(""), loginIsValid: .constant(false), viewModel: LoginViewModel())
		}
	}
}
