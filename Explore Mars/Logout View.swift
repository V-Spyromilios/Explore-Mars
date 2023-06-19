//
//  Logout View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 09.06.23.
//

import SwiftUI

struct LogoutView: View {

	@EnvironmentObject var viewModel: LoginViewModel
	@State var alertIsShown: Bool = false
	@State var alertText: String = ""
	@State var successfulLogout: Bool = false

	@EnvironmentObject var sessionManager: SessionManager

    var body: some View {
		VStack {
			Text("Cu soon!")
				.font(.system(size: 30, weight: .bold, design: .rounded))
			
			Button("Log Out", action: {
				sessionManager.requestLogOut() { result, error in
					if error != nil {
						alertText = error?.localizedDescription ?? "Please try again"
						
					}
					else {
						alertText = "You have been logged out successfully"
						successfulLogout = true
					}
				}
			})
			.frame(height: 18)
			.padding(.all)
			.background {
				 RoundedRectangle(cornerRadius: 7).fill(Color.blue)
			 }.foregroundColor(.white)
		}
		.alert(isPresented: $successfulLogout) {
			Alert(title: Text(successfulLogout ? "Ciao!" : "Logout Failed"),
				  message: Text(alertText),
				  dismissButton: .default(Text("OK"),
										  action: {
				sessionManager.isLoggedin = false}))
		}
    }
}

struct Logout_View_Previews: PreviewProvider {
    static var previews: some View {
		LogoutView()
    }
}
