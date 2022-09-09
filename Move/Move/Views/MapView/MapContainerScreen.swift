//
//  MapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 30.08.2022.
//

import SwiftUI
import MapKit



struct MapContainerScreen: View{
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScooterMapView(viewModel: viewModel.mapViewModel)
                .onAppear {
                    viewModel.mapViewModel.checkIfLocationServiceIsEnabled()
                }
            HStack {
                Button {
                    print("menu")
                } label: {
                    Image(ImagesEnum.goToMenuPin.rawValue)
                }
                .buttonStyle(.simpleMapButton)
                
                Spacer()
                
                Button {
                    self.viewModel.mapViewModel.centerOnUser()
                } label: {
                    
                    
                    Image(self.viewModel.mapViewModel.isCenteredOnUser() ? ImagesEnum.centerMapOnUserPin.rawValue : ImagesEnum.mapNotCenteredOnUser.rawValue)
                }
                .buttonStyle(.simpleMapButton)
            }.padding(.vertical, 64)
                .padding(.horizontal, 24)
            
//            selectedScooterView
                
                
        }
        .onAppear{
            viewModel.loadScooters()
        }
        .overlay(content: {
            ZStack {
                selectedScooterView
                    .transition(.opacity.animation(.default))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.vertical, 46)
            }
        })
    }
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = viewModel.selectedScooter {
            withAnimation {
                ScooterCardView(scooterData: selectedScooter.scooterData, getLocationHandler: {
                    self.viewModel.goToScooterLocation()
                })
                    .shadow(radius: 10)
            }
        }
    }
}


extension MapContainerScreen {
    class ViewModel: ObservableObject {
        @Published var timer = Timer()
        @Published var selectedScooter: ScooterAnnotation?
        @Published var scooters: [Scooter] = .init()
        
        
        var mapViewModel: ScooterMapViewModel = .init()
        
        init () {
            mapViewModel.onSelectedScooter = { scooter in
                self.selectedScooter = scooter
            }
            
            mapViewModel.onDeselectedScooter = {
                self.selectedScooter = nil
            }
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
                self.mapViewModel.refreshScooterList()
            })
            
        }
        
        func goToScooterLocation() {
            // Open and show coordinate
            let url = "maps://?saddr=&daddr=\( selectedScooter!.coordinate.latitude),\(selectedScooter!.coordinate.longitude)"
            print(url)
            UIApplication.shared.openURL(URL(string:url)!)
        }
        
        func loadScooters() {
            ScooterAPI().getAllScooters(completionHandler: { result  in
                switch result {
                case .success(let result):
                    self.scooters = result
                    self.convertScootersToAnnotations()
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        func convertCoordinatesToAddress(scooter: Scooter, completionHandler: @escaping (String) -> Void) {
            let location = CLLocation(latitude: scooter.location!.coordinates![1], longitude: scooter.location!.coordinates![0])
            var address = ""
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if error == nil {
                    address = placemarks?.first?.name ?? "No address"
                    completionHandler(address)
                }
                else {
                    print(error as Any)
                }
            }
        }
        
        func convertScootersToAnnotations() {
            for var scooter in scooters {
                let scooterAnnotation = ScooterAnnotation(coordinate: CLLocationCoordinate2D(latitude: (scooter.location?.coordinates?[1])!, longitude: (scooter.location?.coordinates?[0])!), scooterData: scooter)
                self.mapViewModel.scooters.append(scooterAnnotation)
            }
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen()
            .ignoresSafeArea()
    }
}
