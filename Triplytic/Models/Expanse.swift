//
//  Expanse.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import Foundation

struct Expanse: Identifiable, Codable {
    var id = UUID()
    var category: String
    var title: String
    var trip: Trip
    var amount: Double
    var date: String
    var imageName: String
    var isSpent: Bool
}
