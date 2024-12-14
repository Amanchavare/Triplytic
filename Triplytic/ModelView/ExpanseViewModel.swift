//
//  ExpanseViewModel.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import Foundation

class ExpanseViewModel: ObservableObject{
    @Published var expanses: [Expanse] = []
    
    func addExpanse(category: String, title: String, trip: Trip){
        let newExpanse = Expanse(category: category, title: title, trip: trip)
        expanses.append(newExpanse)
    }
}
