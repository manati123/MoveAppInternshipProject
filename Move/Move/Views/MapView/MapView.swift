//
//  MapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 30.08.2022.
//

import SwiftUI
import MapKit


struct Scooter: Identifiable {
    var id = UUID()
    var location: CLLocationCoordinate2D
    var name: String
}

struct MapView: View {
    @State private var locationIfDenied = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.59138889),
                                                             latitudinalMeters: 4000,
                                                             longitudinalMeters: 4000)
    
    var scooters = [
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.7), name: "C1"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.6), name: "C2"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.4), name: "C3")
      
    ]
    var body: some View {
        Map(coordinateRegion: self.$locationIfDenied, annotationItems: scooters) { scooter in
            MapAnnotation(coordinate: scooter.location){
                    Button {
                        
                    }label: {
                        Image("ClusterDefault")
                            .frame(width: 40, height: 40)
                    }.frame(width: 40, height: 40)
            }
        }
        .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
