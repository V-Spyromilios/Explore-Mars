//
//  Login ViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {

	@Published var email: String = ""
	@Published var password: String = ""


	var loginIsValid: AnyPublisher<Bool, Never> {

		Publishers.CombineLatest($email, $password).map { email, password in

			return email.contains("@") && !password.isEmpty
		}
		.eraseToAnyPublisher()
	}
}
