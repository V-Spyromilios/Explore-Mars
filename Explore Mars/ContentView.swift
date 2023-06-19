//
//  ContentView.swift
//  Explore Mars
//
//  Created by Evangelos Spyromilios on 01.06.23.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var sessionManager: SessionManager
	
	var body: some View {
		
		if sessionManager.isLoggedin {
			TabBarView()
		} else {
			Login_View()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

