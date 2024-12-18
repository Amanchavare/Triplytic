//
//  AddTripForm.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 03/12/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct AddTripForm: View {
    @Environment(HomeViewModel.self) var homeViewModel
    @State private var tripName = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var currency = "EUR"
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    let currencies = [
        "USD", // US Dollar
        "EUR", // Euro
        "INR", // Indian Rupee
        "GBP", // British Pound
        "AUD", // Australian Dollar
        "CAD", // Canadian Dollar
        "JPY", // Japanese Yen
        "CNY", // Chinese Yuan
        "CHF", // Swiss Franc
        "SGD", // Singapore Dollar
        "HKD", // Hong Kong Dollar
        "NZD", // New Zealand Dollar
        "SEK", // Swedish Krona
        "NOK", // Norwegian Krone
        "DKK", // Danish Krone
        "ZAR", // South African Rand
        "AED", // United Arab Emirates Dirham
        "SAR", // Saudi Riyal
        "KRW", // South Korean Won
        "THB", // Thai Baht
        "MYR", // Malaysian Ringgit
        "IDR", // Indonesian Rupiah
        "PHP", // Philippine Peso
        "MXN", // Mexican Peso
        "BRL", // Brazilian Real
        "RUB", // Russian Ruble
        "TRY", // Turkish Lira
        "PLN", // Polish Zloty
        "HUF", // Hungarian Forint
        "CZK", // Czech Koruna
        "ILS", // Israeli New Shekel
        "ARS", // Argentine Peso
        "CLP", // Chilean Peso
        "COP", // Colombian Peso
        "PKR", // Pakistani Rupee
        "EGP", // Egyptian Pound
        "NGN", // Nigerian Naira
        "KES", // Kenyan Shilling
        "BDT", // Bangladeshi Taka
        "VND", // Vietnamese Dong
        "KWD", // Kuwaiti Dinar
        "OMR", // Omani Rial
        "BHD"  // Bahraini Dinar
    ]

    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    
                    VStack{
                        Button(action: {
                            isImagePickerPresented.toggle()
                        }) {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(8)
                            } else {
                                HStack {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    Text("Select an Image")
                                        .font(.headline)
                                }
                            }
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker2(selectedImage: $selectedImage)
                        }

                    }
                    
                    
                    
                    TextField("Trip Name", text: $tripName)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    
                    Picker("Currency", selection: $currency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Add New Trip")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }),
                                
                                trailing: Button("Save") {
                // Save the image and add trip
                if let selectedImage = selectedImage, let imagePath = homeViewModel.saveImageToDocuments(image: selectedImage) {
                    homeViewModel.addTrip(
                        name: tripName,
                        startDate: formatDate(startDate),
                        endDate: formatDate(endDate),
                        currency: currency,
                        imageName: imagePath // Pass image path here
                    )
                }
                presentationMode.wrappedValue.dismiss()
            }
                .disabled(tripName.isEmpty))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ImagePicker2: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker2
        
        init(_ parent: ImagePicker2) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}
