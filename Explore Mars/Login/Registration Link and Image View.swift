//
//  Registration Link and Image View.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 08.06.23.
//

import SwiftUI

struct RegistrationLinkAndImageView: View {
	
	@Binding var isRegistrationComplete: Bool
	@Environment(\.verticalSizeClass) private var verticalSizeClass
	@Binding var loginIsValid: Bool
	
	var body: some View {
		HStack(alignment: .center) {
			//Button(action: { registrationViewIsPresented.toggle() }) { Text("Don't have an account?")}
			NavigationLink("Dont have an Account?", destination: RegistrationView(isRegistrationComplete: $isRegistrationComplete))
				.disabled(false)
				.navigationBarBackButtonHidden(false)
			
			Spacer()
			Image("nasa-logo")
				.frame(width: getImageWidth(), height: getImageHeight())
		}
	}
	
	
	private func getImageHeight() -> CGFloat {
		
		return verticalSizeClass == .compact ? 55 : 88
	}
	
	private func getImageWidth() -> CGFloat {
		
		return verticalSizeClass == .compact ? 46 : 73
	}
}

struct Registration_Link_and_Image_View_Previews: PreviewProvider {
	static var previews: some View {
		RegistrationLinkAndImageView(isRegistrationComplete: .constant(false), loginIsValid: .constant(false))
	}
}
