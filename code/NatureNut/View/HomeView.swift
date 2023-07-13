//
//  HomeView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI
import CoreData
import MapKit

struct HomeView: View {
    @Environment (\.managedObjectContext) var managedObjContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order:.reverse)]) var nature: FetchedResults<Nature>

    @State private var deletionIndexSet: IndexSet?
    @State private var currentDate = Date()
    @State private var showingAddView = false
    @State private var showingMapView = false
    @State private var selectedimage: Data = .init(count: 0)
    @State private var showingDeleteAlert = false

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
               VStack {
                   Text("Let's Start Your Vacation!")
                       .font(.largeTitle)
                       .padding(.leading)
                       .padding(.trailing, 30)

               }
                Text("Interesting Snaps")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal)

                VStack{
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (spacing: 0) {
                            ForEach(0 ..< 4) { i in
                                NavigationLink(
                                    destination: DetailScreen(),
                                    label: {
                                        ProductCardView(image: Image("Land_\(i+1)"), size: 200)
                                    })
                                .navigationBarHidden(true)
                                .foregroundColor(.black)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom)
                }
                Text("Get More Best Snaps")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal)

                List {
                    ForEach(nature){nature in
                        NavigationLink(destination:
                              SpecificNatureView(nature:nature)) {
                            HStack (alignment: .center) {
                                VStack(alignment: .leading) {
                                    if let imageData = nature.selectedimage, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .renderingMode(.original)
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width - 50)
                                            .cornerRadius(25)
                                            .shadow(radius: 6)
                                    }
                                    Spacer()
                                    Spacer()
                                    if nature.name != nil {
                                        Text("Capture Name   : \(nature.name ?? "")").bold()
                                           }
                                    if nature.place != nil {
                                        Text("Place Name        : \(nature.place ?? "")").bold()
                                           }
                                    if nature.type != nil {
                                        Text("Type : \(nature.type ?? "")").bold()
                                           }
                                    if nature.type != nil {
                                        Text("Date : \(formatDate(date: nature.date!))").bold()
                                    }
                                    Text("\(Int(nature.kilometers))") + Text("  Kilometers").foregroundColor(.red).bold()
                                }
                                .frame(height: 300)
                                Spacer()
                            }
                        }
                    }
                    .onDelete { indexSet in
                     deletionIndexSet = indexSet
                      showingDeleteAlert.toggle()

                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("")

//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button {
//                        showingAddView.toggle()
//                    } label :{
//                      Label("Add Nature", systemImage: "plus.circle")
//                    }
//                 //  .padding(.bottom, -1200)
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//            }
//            .sheet(isPresented: $showingAddView) {
//                AddNatureView()
//            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        showingMapView.toggle()
                    } label :{
                      Label("Find Location", systemImage: "map")
                    }
                }
            }
            .sheet(isPresented: $showingMapView) {
                MapPresentView()
            }
        }
        .navigationViewStyle(.stack)
        .alert(isPresented: $showingDeleteAlert) {

                    Alert(
                        title: Text("Delete Capture"),
                        message: Text("Are you sure you want to delete this capture?"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Delete")) {
                            deleteNature()
                        }
                    )
                }
            }

    //delete
//    private func deleteNature(offsets: IndexSet){
//          withAnimation {
//            offsets.map { nature[$0] } .forEach(managedObjContext.delete)
//            DataController().save(context: managedObjContext)
//           }
//       }
    private func deleteNature() {
            if let indexSet = deletionIndexSet {
                withAnimation {
                    indexSet.map { nature[$0] }.forEach(managedObjContext.delete)
                    saveContext()
                }
            }
            deletionIndexSet = nil
        }
        private func saveContext() {

            do {
                try managedObjContext.save()
            } catch {
                print("Error saving context: \(error)")
            }

        }

    //display all
    private func totalKilometersToday() -> Double {
        var kilometersToday :Double = 0
          for item in nature {
              if Calendar.current.isDateInToday(item.date!){
                  kilometersToday += item.kilometers
              }
        }
        return kilometersToday
    }
}

struct ProductCardView: View {
    let image: Image
    let size: CGFloat

    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .cornerRadius(20.0)
//            Text("Click for more Details")
//                .font(.system(size: 17))
//                .fontWeight(.bold)
//
            HStack (spacing: 2) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                }
            }
        }
        .frame(width: size)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)

    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
