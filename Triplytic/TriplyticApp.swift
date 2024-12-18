//
//  TriplyticApp.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import SwiftUI

@main
struct TriplyticApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
        @StateObject private var expanseViewModel = ExpanseViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel) // Provide HomeViewModel
                .environmentObject(expanseViewModel)

        }
    }
}
