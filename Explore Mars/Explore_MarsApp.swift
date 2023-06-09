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

	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	@StateObject private var sessionManager = SessionManager()

    var body: some Scene {

        WindowGroup {
            ContentView()
				.environmentObject(sessionManager)
        }
    }
}
