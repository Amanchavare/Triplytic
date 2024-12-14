//
//  ContentView.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    let homeViewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .environment(homeViewModel)
            
            ExpensesView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Expenses")
                }
                .environment(homeViewModel)
            
            PaymentsView()
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Payments")
                }
            
                
        }

    }
}

#Preview {
    ContentView()
}
