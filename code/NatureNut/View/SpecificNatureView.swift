//
//  SpecificNatureView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI

struct SpecificNatureView: View {
    @Environment(\.managedObjectContext) var managedObjContext

    var nature: Nature // Existing Food object

    @State private var showingDeleteAlert = false
    @State private var showingEditView = false
    @State private var editedCapureName = ""
    @State private var editedCaptureType = ""
    @State private var editedPlace = ""
    @State private var editedDate = Date()
    @State private var editedKilometers = 0

    var body: some View {
        Form {
            Section {
                Text("Capture Name: \(nature.name ?? "")")
                Text("Place: \(nature.place ?? "")")
                Text("Type: \(nature.type ?? "")")
                Text("Date: \(formatDate(date: nature.date))")
                Text("Kilometers: \(Int(nature.kilometers))")
                
                HStack {
                    Spacer()
                    if let imageData = nature.selectedimage, let uiImage = UIImage(data: imageData) {
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
                    Spacer()
                }
                
                //edit
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            showingEditView.toggle()
                        } label :{
                            Label("Edit Capture", systemImage: "pencil.circle.fill")
                                .foregroundColor(.yellow)
                                .font(.title)
                              .padding(10)
                                .bold()
                        }
                    }
                }
                .sheet(isPresented: $showingEditView) {
                    EditNatureView(nature: nature)
                }
                //delete
            }
            HStack{
                Spacer()
            Button(action: {
                showingDeleteAlert.toggle()
            }) {
                Label("Delete Capture", systemImage: "trash.fill")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Nature"),
                message: Text("Are you sure you want to delete this capture?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Delete"), action: deleteNature)
            )
        }
    }

    private func deleteNature() {
        withAnimation {
            managedObjContext.delete(nature)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try managedObjContext.save()
        } catch {
            // Handle the error
        }
    }

    private func formatDate(date: Date?) -> String {
        guard let date = date else {
            return ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: date)
    }
}

