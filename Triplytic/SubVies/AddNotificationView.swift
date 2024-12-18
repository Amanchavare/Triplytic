//
//  AddNotificationView.swift
//  Triplytic experiment 
//
//  Created by Aman Niranjan Chavare on 18/12/24.
//

import SwiftUI

import SwiftUI

struct AddNotificationView: View {
    @ObservedObject var viewModel: NotificationsViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notification Title")) {
                    TextField("Enter title", text: $title)
                }

                Section(header: Text("Select Date")) {
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Notification")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !title.isEmpty {
                            viewModel.addNotification(title: title, date: selectedDate)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
