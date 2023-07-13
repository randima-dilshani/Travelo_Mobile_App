//
//  DataController.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import Foundation
import CoreData
import SwiftUI

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores {
            desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        }catch {
            print("Failed to saved")
        }
    }
    func addNature(name:String, place:String, kilometers:Double,type:String, context:NSManagedObjectContext){
        let nature = Nature(context: context)
        nature.name = name
        nature.id = UUID()
        nature.place = place
        nature.kilometers = kilometers
        nature.date = Date()
        nature.type = type
        save(context: context)
    }
    
    func editNature(nature: Nature, name:String,place:String, kilometers:Double, type:String, context:NSManagedObjectContext){
        nature.date = Date()
        nature.name = name
        nature.place = place
        nature.type = type
        nature.kilometers = kilometers
        save(context: context)
    }
}

