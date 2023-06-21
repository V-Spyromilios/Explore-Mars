//
//  PhotoDetailView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 21.06.23.
//

import SwiftUI

struct PhotoDetailView: View {
	var photo: RoverPhotos.Photo

    var body: some View {
		Text(photo.urlSource).font(.title)
    }
	
}

struct PhotoDetailView_Previews: PreviewProvider {

    static var previews: some View {
		PhotoDetailView(photo: .init())
    }
}
