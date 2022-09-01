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

class mapViewViewModel: ObservableObject {
    @Published var locationManager = LocationModel()
    @Published var locationIfDenied = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.59138889),
                                                         latitudinalMeters: 4000,
                                                         longitudinalMeters: 4000)
    @Published var tracking: MapUserTrackingMode = .follow
    
    var scooters = [
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.7), name: "C1"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.6), name: "C2"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.4), name: "C3")
    ]
}

struct MapView: View {
    @StateObject var viewModel = mapViewViewModel()
    
    var body: some View {
        Map(
            coordinateRegion: $viewModel.locationManager.region,
           interactionModes: MapInteractionModes.all,
           showsUserLocation: true,
            userTrackingMode: $viewModel.tracking,
            annotationItems: viewModel.scooters,
            annotationContent: { scooter in
                MapAnnotation(coordinate: scooter.location) {
                    Button {
                        print("hello brosci")
                    }
                label: {
                    Image("ClusterDefault")
                        .frame(width:20, height: 20)
                }
                }
            }
        )
        .ignoresSafeArea()
        .onAppear {
            self.viewModel.locationManager.requestAuthorisation()
        }
        
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
