//
//  PhotoDetailView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 21.06.23.
//

import SwiftUI

struct PhotoDetailView: View {
	var image: RoverPhotos.Photo

    var body: some View {
		Text("\(image.dateTaken)")
//		image.resizable().aspectRatio(contentMode: .fill).ignoresSafeArea()
    }
	
}

//struct PhotoDetailView_Previews: PreviewProvider {
//
//    static var previews: some View {
//		PhotoDetailView(image: Image(systemName: "up"))
//    }
//}
