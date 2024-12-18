//
//  AddExpanseForm.swift
//  Triplytic
//
//  Created by Aman Niranjan Chavare on 13/12/24.
//

import SwiftUI

struct AddExpanseForm: View {
    @ObservedObject var expanseViewModel: ExpanseViewModel
    let homeViewModel: HomeViewModel
    
    @State private var category = ""
    @State private var title = ""
    @State private var trip = ""
    @State private var amount: Double = 0
    @State private var inputText = ""
    @State private var date: Date = Date()
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    let categories = ["Restaurant", "Travel", "Accommodation", "Shopping", "Utilities", "Groceries", "Activities", "Coffee", "Drinks", "Flight", "General", "Fee & Charges", "Exchange Fee", "Entertainment", "Laundry", "Others"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section() {
                    Picker("Category", selection: $category) {
                        Text("Select").tag("")
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    
                    
                    TextField("Title", text: $title)
                    
                    
                    Picker("Trip Name", selection: $trip) {
                        Text("Select").tag("")
                        ForEach(homeViewModel.trips, id: \.self) { trip in
                            Text(trip.name)
                                .tag(trip.name)
                        }
                    }
                    
                    
                    TextField("Amount", text: $inputText)
                        .keyboardType(.decimalPad)
                        .onChange(of: inputText) {newValue in
                            amount = Double(newValue) ?? 0
                        }
                    
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    
                    
                    
                    VStack{
                        Button(action: {
                            isImagePickerPresented.toggle()
                        }, label: {
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
                        })
                        .sheet(isPresented: $isImagePickerPresented) {
                            CustomImagePicker(selectedImage: $selectedImage)
                                
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Add Expanse")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
            .navigationBarItems(trailing: Button(action: {
                if let selectedImage = selectedImage,
                   let imagePath = expanseViewModel.saveImageToDocuments(image: selectedImage){
                    if let selectedTrip = homeViewModel.trips.first(where: {$0.name == trip}){
                        expanseViewModel.addExpanse(category: category, title: title, trip: selectedTrip,amount: amount, date: formatDate(date), imageName: imagePath)
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("save")
            })
                )
        
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}


struct CustomImagePicker: UIViewControllerRepresentable {
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
        let parent: CustomImagePicker
        
        init(_ parent: CustomImagePicker) {
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
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
