//
//  ExpanseViewModel.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import Foundation
import UIKit

@Observable
class ExpanseViewModel: ObservableObject{
     var expanses: [Expanse] = []{
        didSet {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(expanses)
                UserDefaults.standard.setValue(encoded, forKey: "Expanses")
            } catch {
                print("Failed to encode expanses:\(error.localizedDescription)")
            }
        }
    }
    
    
    init(expanses: [Expanse] = []){
        if let data = UserDefaults.standard.data(forKey: "Expanses"){
            let decoder = JSONDecoder()
            do{
                let decodedExpanses = try decoder.decode([Expanse].self, from: data)
                self.expanses = decodedExpanses
            } catch {
                print("Failed to decode expanses from UserDefaults:\(error.localizedDescription)")
                self.expanses = expanses
            }
        } else {
            self.expanses = expanses
        }
    }
    
    
    func addExpanse(category: String, title: String, trip: Trip, amount: Double, date: String, imageName: String, isSpent: Bool = false){
        let newExpanse = Expanse(category: category, title: title, trip: trip, amount: amount, date: date, imageName: imageName, isSpent: isSpent)
        expanses.append(newExpanse)
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
    
    func deleteExpenses(at offsets: IndexSet) {
            expanses.remove(atOffsets: offsets)
    }
    
   
   
}

