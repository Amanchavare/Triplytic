//
//  HomeViewModel.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import Foundation
import UIKit

@Observable
class HomeViewModel: ObservableObject{
    var trips: [Trip] = []
    
    
    
    func addTrip(name: String, startDate: String, endDate: String, currency: String, image: UIImage?) {
        let newTrip = Trip(name: name, startDate: startDate, endDate: endDate, currency: currency, image: image)
        trips.append(newTrip)
    }
}
