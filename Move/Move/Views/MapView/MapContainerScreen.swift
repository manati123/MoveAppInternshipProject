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
            
            selectedScooterView
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.vertical, 46)
                
        }.onAppear{
            viewModel.loadScooters()
        }
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
        @Published var selectedScooter: ScooterAnnotation?
        var mapViewModel: ScooterMapViewModel = .init()
        
        init () {
            mapViewModel.onSelectedScooter = { scooter in
                self.selectedScooter = scooter
            }
            
            mapViewModel.onDeselectedScooter = {
                self.selectedScooter = nil
            }
            
        }
        
        func goToScooterLocation() {
            // Open and show coordinate
            let url = "maps://?saddr=&daddr=\( selectedScooter!.coordinate.latitude),\(selectedScooter!.coordinate.longitude)"
            print(url)
            UIApplication.shared.openURL(URL(string:url)!)
        }
        
        func loadScooters() {
            mapViewModel.scooters = ScooterAnnotation.requestMockData()
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen()
            .ignoresSafeArea()
    }
}
