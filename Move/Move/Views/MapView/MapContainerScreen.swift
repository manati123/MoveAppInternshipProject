//
//  MapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 30.08.2022.
//

import SwiftUI
import MapKit



struct MapContainerScreen: View{
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    @StateObject private var viewModel: ViewModel = .init()
    let onGoValidateWithCode:() -> Void
    let onGoToMenu:() -> Void
    var body: some View {
        ZStack(alignment: .top) {
            ScooterMapView(viewModel: viewModel.mapViewModel)
                .onAppear {
                    viewModel.mapViewModel.checkIfLocationServiceIsEnabled()
                }
            topTitleBar
        }
        .onAppear{
            viewModel.loadScooters()
            viewModel.convertUserCoordinatesToAddress()
        }
        .halfSheet(showSheet: self.$viewModel.showUnlockingSheet) {
            scooterToBeUnlockedView
        } onEnd: {
            self.viewModel.showUnlockingSheet = false
        }
//        .halfSheet(showSheet: self.$mapCoordinatorViewModel.showStartRideSheet) {
//            startRideSheetView
//        } onEnd: {
//            self.mapCoordinatorViewModel.showStartRideSheet = false
//        }
        
        .overlay(content: {
            ZStack {
                selectedScooterView
                    .transition(.opacity.animation(.default))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.vertical, 46)
                    .id(UUID())
            }
        })
                
        .navigationBarHidden(true)
        
        
    }
    
    var topTitleBar: some View {
        HStack {
            Button {
                onGoToMenu()
            } label: {
                Image(ImagesEnum.goToMenuPin.rawValue)
            }
            .buttonStyle(.simpleMapButton)
            
            Spacer()
            Text(self.viewModel.mapViewModel.locationIsDisabled() ? "Allow location" : self.viewModel.userLocation)
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
            Spacer()
            
            Button {
                withAnimation {
                    self.viewModel.mapViewModel.toggleUserTrackingMode()
                }
            } label: {
                Image(self.viewModel.followingUser() ? ImagesEnum.centerMapOnUserPin.rawValue : ImagesEnum.mapNotCenteredOnUser.rawValue)
                    .animation(.default, value: self.viewModel.followingUser())
            }
            .buttonStyle(.simpleMapButton)
        }.padding(.vertical, 64)
            .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = viewModel.selectedScooter {
            withAnimation {
                ScooterCardView(isEnabled: self.viewModel.mapViewModel.checkMinimumDistanceAndLocationEnabled(selectedScooterLocation: selectedScooter.coordinate), scooter: selectedScooter.scooterData, getLocationHandler: {
                    self.viewModel.goToScooterLocation()
                }, showSheet: {self.viewModel.showUnlockingSheet = true})
                    .shadow(radius: 10)
            }
        }
    }
    
    @ViewBuilder
    var startRideSheetView: some View {
        if let selectedScooter = viewModel.selectedScooter {
            withAnimation {
                StartRideSheetView(scooter: selectedScooter.scooterData, onStartRide: {
                    self.mapCoordinatorViewModel.showStartRideSheet = false
                })
            }
        }
    }
    
    @ViewBuilder
    var scooterToBeUnlockedView: some View {
        if let selectedScooter = viewModel.selectedScooter {
             withAnimation {
                UnlockScooterSheetView(scooter: selectedScooter.scooterData, onGoValidateWithCode: {
                    self.onGoValidateWithCode()
                    self.viewModel.showUnlockingSheet = false
                    if let selectedScooterData = self.viewModel.selectedScooter?.scooterData {
                        self.mapCoordinatorViewModel.selectedScooter = selectedScooterData
                    }
                })
            }
        }
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen(mapCoordinatorViewModel: .init(), onGoValidateWithCode: {}, onGoToMenu: {})
            .ignoresSafeArea()
    }
}
