////
////  AllNatureView.swift
////  NatureNut
////
////  Created by Sajani Jayasinghe on 2023-06-17.
////
//
//import SwiftUI
//import CoreData
//
//struct AllNatureView: View {
//    @Environment (\.managedObjectContext) var managedObjContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order:.reverse)]) var nature: FetchedResults<Nature>
//
//    @State private var searchText = ""
//    @State private var isSearching = false
//    @State private var currentDate = Date()
//    @State private var showingAddView = false
//    @State private var selectedimage: Data = .init(count: 0)
//
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                List {
//                    ForEach(nature){ nature in
//                        NavigationLink(destination:
//                          SpecificNatureView(nature:nature)) {
//
//                            HStack (alignment: .center) {
//                                VStack(alignment: .leading) {
//                                    if let imageData = nature.selectedimage, let uiImage = UIImage(data: imageData) {
//                                        Image(uiImage: uiImage)
//                                            .renderingMode(.original)
//                                            .resizable()
//                                            .frame(width: 200)
//                                            .cornerRadius(25)
//                                            .shadow(radius: 6)
//                                            .padding(.leading, 50)
//                                    }
//                                    Spacer()
//                                    Spacer()
//                                    if nature.name != nil {
//                                        Text("Capture Name   : \(nature.name ?? "")").bold()
//                                           }
//                                    if nature.place != nil {
//                                        Text("Place Name        : \(nature.place ?? "")").bold()
//                                           }
//                                    if nature.type != nil {
//                                        Text("Type : \(nature.type ?? "")").bold()
//                                           }
//                                    if nature.type != nil {
//                                        Text("Date : \(formatDate(date: nature.date!))").bold()
//                                    }
//                                    Text("\(Int(nature.kilometers))") + Text("  Kilometers").foregroundColor(.red).bold()
//                                }
//                                .frame(height: 250)
//                                Spacer()
//                            }
//                        }
//                    }
//                }
//                .listStyle(.plain)
//            }
//            .navigationTitle("All Snaps")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button {
//                        showingAddView.toggle()
//                    } label :{
//                      Label("Add Animal", systemImage: "plus.circle")
//                    }
//                }
//            }
//            .sheet(isPresented: $showingAddView) {
//                AddNatureView()
//            }
//        }
//        .navigationViewStyle(.stack)
//    }
//    //display all
//    private func totalKilometersToday() -> Double {
//        var kilometersToday :Double = 0
//          for item in nature {
//              if Calendar.current.isDateInToday(item.date!){
//                  kilometersToday += item.kilometers
//              }
//        }
//        return kilometersToday
//    }
//}
//
//
//struct AllNatureView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllNatureView()
//    }
//}

import SwiftUI
import CoreData

struct AllNatureView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var nature: FetchedResults<Nature>
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var currentDate = Date()
    @State private var showingAddView = false
    @State private var selectedimage: Data = .init(count: 0)
    
    var filteredNature: [Nature] {
        if searchText.isEmpty {
            return Array(nature)
        } else {
            return nature.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(text: $searchText, isSearching: $isSearching)
                    .padding(.horizontal)
                
                List(filteredNature) { nature in
                    NavigationLink(destination: SpecificNatureView(nature: nature)) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                if let imageData = nature.selectedimage, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 200)
                                        .cornerRadius(25)
                                        .shadow(radius: 6)
                                        .padding(.leading, 50)
                                }
                                Spacer()
                                Spacer()
                                if let name = nature.name {
                                    Text("Capture Name   : \(name)").bold()
                                }
                                if let place = nature.place {
                                    Text("Place Name        : \(place)").bold()
                                }
                                if let type = nature.type {
                                    Text("Type : \(type)").bold()
                                }
                                if let date = nature.date {
                                    Text("Date : \(formatDate(date: date))").bold()
                                }
                                Text("\(Int(nature.kilometers))") + Text("  Kilometers").foregroundColor(.red).bold()
                            }
                            .frame(height: 250)
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("All Snaps")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Animal", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddNatureView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct AllNatureView_Previews: PreviewProvider {
    static var previews: some View {
        AllNatureView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .transition(.move(edge: .trailing))
                .animation(.easeInOut)
            }
        }
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
    }
}
