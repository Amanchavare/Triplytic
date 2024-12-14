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
            VStack{
                Spacer()
                HStack{
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

#Preview {
    ExpensesView()
}
