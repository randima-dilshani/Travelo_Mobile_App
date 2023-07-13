//
//  NatureNutApp.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI

@main
struct NatureNutApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}


