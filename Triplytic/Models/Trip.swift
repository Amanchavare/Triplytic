//
//  Trip.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import Foundation
import UIKit

struct Trip: Identifiable,Hashable {
    var id = UUID()
    var name: String
    var startDate: String
    var endDate: String
    var currency: String
    let image: UIImage?
}


