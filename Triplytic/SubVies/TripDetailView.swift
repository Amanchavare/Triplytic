//
//  TripDetailView.swift
//  Triplytic experiment 
//
//  Created by Aman Niranjan Chavare on 17/12/24.
//

import SwiftUI

struct TripDetailView: View {
    var trip: Trip
    @ObservedObject var expanseViewModel: ExpanseViewModel

     var totalExpenses: Double {
            expanseViewModel.expanses
                .filter { $0.trip.id == trip.id }
                .reduce(0) { $0 + $1.amount }
        }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Trip Image
                if !trip.imageName.isEmpty, let image = UIImage(named: trip.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }

                // Trip Name and Dates
                VStack(alignment: .leading, spacing: 8) {
                    Text(trip.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {
                        Label(trip.startDate, systemImage: "calendar")
                            .foregroundColor(.blue)
                        Text("to")
                            .foregroundColor(.gray)
                        Label(trip.endDate, systemImage: "calendar")
                            .foregroundColor(.blue)
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal)

                Divider()

                // Trip Details Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Trip Details")
                        .font(.title2)
                        .fontWeight(.semibold)

                    HStack {
                            Image(systemName: "sum")
                            .foregroundColor(.orange)
                             Text("Total Expenses: \(totalExpenses, specifier: "%.2f") \(trip.currency)")
                             .foregroundColor(.gray)
                      }
                }
                .padding(.horizontal)

                Divider()

                // Action Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Action for editing the trip
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit Trip")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    Button(action: {
                        // Action for deleting the trip
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Trip")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
