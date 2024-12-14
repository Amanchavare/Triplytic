//
//  AddExpanseForm.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import SwiftUI

struct AddExpanseForm: View {
    @ObservedObject var expanseViewModel: ExpanseViewModel
    let homeViewModel: HomeViewModel
    
    @State private var category = ""
    @State private var title = ""
    @State private var trip = ""
    
    let categories = ["Restaurant", "Travel", "Accommodation", "Shopping", "Utilities"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section() {
                    Picker("Category", selection: $category) {
                        Text("Select").tag("")
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    
                    
                    TextField("Title", text: $title)
                    
                    Picker("Trip Name", selection: $trip) {
                        Text("Select").tag("")
                        ForEach(homeViewModel.trips, id: \.self) { trip in
                            Text(trip.name)
                                .tag(trip.name)
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Add Expanse")
        
        }
    }
}


