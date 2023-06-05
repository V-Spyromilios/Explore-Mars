//
//  okButton.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 02.06.23.
//

import SwiftUI

struct okButton: View {
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.frame(width: 90.0, height: 30.0)
			Button("Okie Dokie", action: {
				print("Button Pressed.")
			})
				.font(.callout)
				.fontWeight(.medium)
				.padding()
				.foregroundColor(.white)
		}
		.foregroundColor(.blue)
    }
}

struct okButton_Previews: PreviewProvider {
    static var previews: some View {
        okButton()
    }
}
