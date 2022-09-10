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
                Text(self.viewModel.userLocation)
                    .font(Font.baiJamjuree.heading2)
                    .foregroundColor(Color.primaryPurple)
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
            viewModel.convertUserCoordinatesToAddress()
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



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen()
            .ignoresSafeArea()
    }
}
