//
//  MapView.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapController: MapController

    var body: some View {
        Map(coordinateRegion: $mapController.region, annotationItems: mapController.businesses) { business in
            MapAnnotation(coordinate: business.coordinate) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.title)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        mapController.setSelectBusiness(for: business)
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $mapController.isBusinessViewShowing) {
            BusinessView(mapController: mapController)
                .presentationDetents([.fraction(0.27), .large])
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapController: MapController())
    }
}
