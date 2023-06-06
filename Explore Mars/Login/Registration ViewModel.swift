//
//  Registration ViewModel.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 06.06.23.
//

import Foundation
import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject {
	
	@Published var newEmail: String = ""
	@Published var newPassword: String = ""
	
	var registrationIsValid: AnyPublisher<Bool, Never> {
		
		Publishers.CombineLatest($newEmail, $newPassword)
			.map { newEmail, newPassword in

				return newEmail.contains("@") && !newPassword.isEmpty
			}
			.eraseToAnyPublisher()
	}
	
}

