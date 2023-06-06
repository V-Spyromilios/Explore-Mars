//
//  registrationBackgroundView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 06.06.23.
//

import SwiftUI

struct registrationBackgroundView: View {
    var body: some View {
		GeometryReader { geometry in
			Image("Airfield")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.ignoresSafeArea()
				.frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
		}
    }
}

struct registrationBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        registrationBackgroundView()
    }
}
