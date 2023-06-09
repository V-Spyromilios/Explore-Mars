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

	func signIn(withEmail email: String, password: String, completion: @escaping (Bool) -> Void) {

		FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
			guard let _ = self else { //not to lose self while in async
				completion(false)
				return
			}
			if let error = error {
				print("Sign-in failed with error: \(error.localizedDescription)")
				completion(false)
			} else {
				self?.isLoggedin = true
				completion(true)
			}
		}
	}

	func requestLogOut(completion: @escaping (Bool, NSError?) -> Void) {

		let firebaseAuth = Auth.auth()
		do {
		  try firebaseAuth.signOut()
			isLoggedin = true
			completion(true, nil)
		} catch let signOutError as NSError {
			completion(false, signOutError)
		}
	}
}
