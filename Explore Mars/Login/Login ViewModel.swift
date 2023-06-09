//
//  Login ViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI
import Combine
import FirebaseAuth

class LoginViewModel: ObservableObject {

	@Published var email: String = ""
	@Published var password: String = ""


	var loginIsValid: AnyPublisher<Bool, Never> {

		Publishers.CombineLatest($email, $password).map { email, password in

			return email.contains("@") && !password.isEmpty
		}
		.eraseToAnyPublisher() //Covert to 'AnyPublisher' type.
	}

	func signIn(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {

		FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
			guard let strongSelf = self else { //not to lose self while in async
				completion(false)
				return
			}
			if let error = error {
				print("Sign-in failed with error: \(error.localizedDescription)")
				completion(false)
			} else {
				completion(true)
			}
		}
	}
}
