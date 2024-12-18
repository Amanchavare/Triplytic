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
    var trips: [Trip] = [] {
        didSet{
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(trips)
                UserDefaults.standard.setValue(encoded, forKey: "Trips")
            } catch {
                print("Failed to encode trips: \(error.localizedDescription)")
            }
        }
    }
    
    init(trips: [Trip] = []) {
        if let data = UserDefaults.standard.data(forKey: "Trips"){
            let decoder = JSONDecoder()
            do{
                let decodedTrips = try decoder.decode([Trip].self, from: data)
                self.trips = decodedTrips
            } catch{
                print("Failed to decode trips from UserDefaults:\(error.localizedDescription)")
                self.trips = trips
            }
        } else {
            self.trips = trips
        }
    }
    
    func addTrip(name: String, startDate: String, endDate: String, currency: String, imageName: String) {
        let newTrip = Trip(name: name, startDate: startDate, endDate: endDate, currency: currency, imageName: imageName)
        trips.append(newTrip)
    }
    
    func saveImageToDocuments(image: UIImage) -> String? {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let fileName = UUID().uuidString + ".jpg"
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Error saving image: \(error)")
            }
        }
        return nil
    }
    
    func deleteTrip(at offsets: IndexSet){
        trips.remove(atOffsets: offsets)
    }
}
