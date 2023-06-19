//
//  SessionManager.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 09.06.23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

class SessionManager: ObservableObject {

	@Published var isLoggedin: Bool = false

	enum SessionError: String, Error {

		case errorSelf = "Error while capturing self"
		case errorSignIn = "Sign-in failed with error"
	}

	func signIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {

		FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
			guard let _ = self else { //not to lose self while in async
				print(SessionError.errorSelf)
				completion(nil, SessionError.errorSelf)
				return
			}
			if let error = error {
				print("\(SessionError.errorSignIn)! -> \(error.localizedDescription)")
				completion(authResult, error)
			} else {
				self?.isLoggedin = true
				completion(authResult, nil)
			}
		}
	}

	func requestLogOut(completion: @escaping (Bool, NSError?) -> Void) {

		let firebaseAuth = Auth.auth()
		do {
		  try firebaseAuth.signOut()
			isLoggedin = false
			completion(true, nil)
		} catch let signOutError as NSError {
			completion(false, signOutError)
		}
	}
}
