//
//  Login ViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import Foundation

final class User: ObservableObject {

	@Published var email: String = ""
	@Published var password: String = ""
}
