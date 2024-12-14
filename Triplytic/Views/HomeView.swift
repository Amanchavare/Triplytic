//
//  HomeView.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) var homeViewModel
    @State private var showAddTripForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if(homeViewModel.trips.isEmpty){
                    Spacer()
                    Text("No trips added yet!")
                        .font(.title)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Text("Tap the + button to add your first trip.")
                         .font(.subheadline)
                          .foregroundColor(.gray)
                          .multilineTextAlignment(.center)
                          .padding(.top, 8)
                     Spacer()
                }else{
                    List(homeViewModel.trips) { trip in
                        TripRow(trip: trip) // Custom row to show trip details
                    }
                }
                
                // Floating Action Button (FAB) to add a trip
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddTripForm.toggle() // Show the form when clicked
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue))
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
            .navigationTitle("Triplytic")
            .sheet(isPresented: $showAddTripForm) {
                AddTripForm(homeViewModel: _homeViewModel)
            }
        }
    }
}

struct TripRow: View {
    var trip: Trip
    
    var body: some View {
        HStack {
            if let image = trip.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(trip.name).font(.headline)
                Text("\(trip.startDate) - \(trip.endDate)").font(.subheadline)
            }
        }
    }
}
