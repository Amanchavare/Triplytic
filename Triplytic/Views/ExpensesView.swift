//
//  ExpensesView.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import SwiftUI

struct ExpensesView: View {
    @StateObject private var expanseViewModel = ExpanseViewModel()
    @Environment(HomeViewModel.self) var homeViewModel
    @State private var showAddExpanseForm = false
    

    var body: some View {
        NavigationView {
            VStack {
                if expanseViewModel.expanses.isEmpty {
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
                } else {
                    Text("Remaining Expanses")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    List {
                        ForEach(expanseViewModel.expanses) { expanse in
                            if !expanse.isSpent {
                                ExpanseRow(
                                    expanse: expanse,
                                    actionButtonTitle: "Mark as Spent",
                                    action: {
                                        expanseViewModel.toggleExpanseSpentStatus(expanse)
                                    }
                                )
                                .padding(.horizontal)
                            }
                        }
                        .onDelete(perform: expanseViewModel.deleteExpenses)
                    }
                    
                    Text("Spent Expanses")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    List {
                        // Spent Expanses Section
                        ForEach(expanseViewModel.expanses) { expanse in
                            if expanse.isSpent {
                                ExpanseRow(
                                    expanse: expanse,
                                    actionButtonTitle: nil,
                                    action: nil
                                )
                                .padding(.horizontal)
                            }
                        }
                        .onDelete(perform: expanseViewModel.deleteExpenses)
                    }
                    
                }

                Spacer()

                // Add Expense Button
                HStack {
                    Spacer()
                    Button(action: {
                        showAddExpanseForm.toggle()
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
            .sheet(isPresented: $showAddExpanseForm) {
                AddExpanseForm(expanseViewModel: expanseViewModel, homeViewModel: homeViewModel)
            }
        }
    }

    
}

struct ExpanseRow: View {
    var expanse: Expanse
    var actionButtonTitle: String?
    var action: (() -> Void)?

    var body: some View {
        HStack {
            let imagePath = expanse.imageName
            if !imagePath.isEmpty,
               let image = UIImage(named: imagePath) {
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
                Text(expanse.title)
                    .font(.headline)
                Text(String(format: "%.2f", expanse.amount)) 
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            if let actionButtonTitle = actionButtonTitle, let action = action {
                Button(action: action) {
                    Text(actionButtonTitle)
                        .font(.caption)
                        .padding(6)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(4)
                }
            } else if expanse.isSpent {
                Text("Paid")
                    .font(.caption)
                    .foregroundColor(.green)
                    .padding(6)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(4)
            } else {
                Text("Remaining")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(6)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 8)
    }
}

extension ExpanseViewModel {
    func toggleExpanseSpentStatus(_ expanse: Expanse) {
        if let index = expanses.firstIndex(where: { $0.id == expanse.id }) {
            expanses[index].isSpent.toggle()
        }
    }
}

#Preview {
    ExpensesView()
}
