//
//  LoginbackgroundView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 05.06.23.
//

import SwiftUI

struct LoginbackgroundView: View {
	var body: some View {

		GeometryReader { geometry in
			Image("Mars_Valles_Marineris")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.ignoresSafeArea()
				.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
		}
	}
}

struct LoginbackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LoginbackgroundView()
    }
}
