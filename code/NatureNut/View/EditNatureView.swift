//
//  EditNatureView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI
import PhotosUI

struct EditNatureView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var nature: Nature // Existing Food object
    let types = ["Plants", "Places", "Flowers","Animals"]
    
    @State private var name: String
    @State private var place: String
    @State private var type: String
    @State private var kilometers: Double
    @State private var selectedimage: Data
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedDate = Date()
    
    
    // Initialize the state variables with the values from the existing Food object
    init(nature: Nature) {
        self.nature = nature
        _name = State(initialValue: nature.name ?? "")
        _place = State(initialValue: nature.place ?? "")
        _type = State(initialValue: nature.type ?? "")
        _selectedDate = State(initialValue: nature.date ?? Date())
        _kilometers = State(initialValue: nature.kilometers)
        _selectedimage = State(initialValue: nature.selectedimage ?? Data(count: 0))
    }
    
    var body: some View {
        Form {
            Section {
                HStack{
                    Text("Capture Name:")
                    TextField("Enter Capture Name", text: $name)
                }
                HStack{
                    Text("Place Name:")
                    TextField("Place", text: $place)
                }
                HStack{
                    Text("Kilometers: \(Int(kilometers))")
                    Slider(value: $kilometers, in: 0...1000, step: 10)
                }
                .padding()
                
                // Date picker
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                
                //type picker
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    //MARK: PhotoPicker
                    PhotosPicker(selection: $selectedItems,
                                 maxSelectionCount: 1,
                                 matching: .images) {
                        if !selectedimage.isEmpty, let uiImage = UIImage(data: selectedimage) {
                            Image(uiImage: uiImage)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                                .foregroundColor(.gray)
                        }
                    }//MARK: PhotoPicker
                    Spacer()
                }//MARK: HStack
                .onChange(of: selectedItems) { new in
                    guard let items = selectedItems.first else { return }
                    
                    items.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                self.selectedimage = data
                            } else {
                                print("No data :(")
                            }
                        case .failure(let error):
                            fatalError("\(error)")
                        }
                    }//MARK: loadTransferable
                }//MARK: onChange
            Spacer()
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            
                            HStack(spacing: 5) {
                                Text("Cancel")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 250, height: 40)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity)
                    }

                    HStack {
                        Button(action: {
                            // Update the existing Food object instead of creating a new one
                            nature.name = name
                            nature.date = selectedDate
                            nature.place = place
                            nature.type = type
                            nature.kilometers = kilometers
                            nature.selectedimage = selectedimage
                            
                            // Save the changes
                            try! managedObjContext.save()
                            
                            dismiss()
                        }) {
                            HStack(spacing: 5) {
                                           Image(systemName: "checkmark")
                                               .resizable()
                                               .frame(width: 20, height: 20)
                                               .foregroundColor(.white)
                                           
                                           Text("Save")
                                               .font(.headline)
                                               .foregroundColor(.white)
                                       }
                                   }
                                   .frame(width: 250, height: 40)
                                   .background(Color.green)
                                   .cornerRadius(8)
                                   .buttonStyle(.plain)
                                   .frame(maxWidth: .infinity)
                                   .disabled(name.count > 2 && place.count > 2 && !selectedimage.isEmpty ? false : true)
                        Spacer()
                    }
                   
                }
                }
            }
        }
}


