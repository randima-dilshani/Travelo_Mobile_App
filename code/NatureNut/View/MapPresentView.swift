//
//  MapPresentView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI

struct MapPresentView: View {

    @StateObject var mapController = MapController()
        func onRun (serchKey: String) {
            mapController.searchTerm = serchKey
            mapController.search()
        }

    var body: some View {
        VStack {
          MapView(mapController: mapController)
        }
          .onAppear(){
            onRun(serchKey: "Forests")
        }
    }
}

struct MapPresentView_Previews: PreviewProvider {
    static var previews: some View {
        MapPresentView()
    }
}

