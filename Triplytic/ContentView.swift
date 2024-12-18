//
//  ContentView.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ExpensesView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Expenses")
                }
            
            NotesJournalView()
                .tabItem {
                                    Image(systemName: "book.fill")
                                    Text("Notes")
                                }
            NotificationsView()
                           .tabItem {
                               Image(systemName: "bell.fill")
                               Text("Notifications")
                           }
            
            ProfileView()
                            .tabItem {
                                Image(systemName: "person.circle.fill")
                                Text("Profile")
                            }
                
        }

    }
}

