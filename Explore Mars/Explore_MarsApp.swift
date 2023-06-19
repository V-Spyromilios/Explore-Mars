//
//  Explore_MarsApp.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		
		return true
	}
}

@main
struct Explore_MarsApp: App {

	@StateObject var loginViewModel = LoginViewModel()
	@StateObject private var sessionManager = SessionManager()
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate //for Firebase
	
	var body: some Scene {
		WindowGroup {

			if sessionManager.isLoggedin {
				TabBarView()
					
			} else {
				ContentView()
					.environmentObject(sessionManager)
					.environmentObject(loginViewModel)
			}
		}
	}
}
