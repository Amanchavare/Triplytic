//
//  Expanse.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import Foundation

struct Expanse: Identifiable {
    var id = UUID()
    var category: String
    var title: String
    var trip: Trip
}