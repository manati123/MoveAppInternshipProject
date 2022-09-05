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

class MapViewViewModel: ObservableObject {
    @Published var locationManager = LocationModel()
    @Published var locationIfDenied = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.59138889),
                                                         latitudinalMeters: 4000,
                                                         longitudinalMeters: 4000)
    @Published var tracking: MapUserTrackingMode = .follow
    
    var scooters = [
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77000000, longitude: 23.7), name: "C1"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77300000, longitude: 23.7), name: "C4"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77200000, longitude: 23.7), name: "C5"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77100000, longitude: 23.7), name: "C6"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77400000, longitude: 23.7), name: "C7"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77500000, longitude: 23.6), name: "C2"),
        Scooter(location: CLLocationCoordinate2D(latitude: 46.77600000, longitude: 23.4), name: "C3")
    ]
}

struct MapView: View {
    @StateObject var viewModel = MapViewViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            map
                .onAppear {
                    self.viewModel.locationManager.requestAuthorisation()
                }
            topSideButtons
        }
        
    }
    
    var map: some View {
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
                        let url = URL(string: "maps://?saddr=&daddr=\(scooter.location.latitude),\(scooter.location.longitude)")
                        
                        if UIApplication.shared.canOpenURL(url!) {
                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                        }
                    }
                label: {
                    Image("ClusterDefault")
                        .frame(width:20, height: 20)
                }
                }
            }
        )
        .ignoresSafeArea()
    }
    
    var topSideButtons: some View {
        HStack {
            Button {
                
            } label: {
                Image("GotoMenuPin")
            }
            .buttonStyle(.simpleMapButton)
            
            Spacer()
            
            Button {
                
            } label: {
                Image("UserNotCenteredPin")
            }
            .buttonStyle(.simpleMapButton)
        }.padding(.horizontal, 24)
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
