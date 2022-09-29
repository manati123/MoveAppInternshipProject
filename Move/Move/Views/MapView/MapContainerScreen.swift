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
//            Image(uiImage: self.viewModel.mapViewModel.mapSnapshot)
        }
        .onAppear{
            viewModel.loadScooters()
            viewModel.convertUserCoordinatesToAddress()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.viewModel.mapViewModel.drawTrip()
//            }
        }
        .overlay(
            FlexibleSheet(sheetDetents: .constant(self.mapCoordinatorViewModel.sheetPresentationDetents)) {
                
                sheetMode
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.neutralWhite)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            }
        )
        .halfSheet(showSheet: self.$viewModel.showUnlockingSheet) {
            scooterToBeUnlockedView
                

        } onEnd: {
            self.viewModel.showUnlockingSheet = false
        }

        
        
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
            Text(self.viewModel.mapViewModel.locationAllowed == false ? "Allow location" : self.viewModel.userLocation)
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
                .onTapGesture {
                    if self.viewModel.mapViewModel.locationIsDisabled() {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                }
                .id(UUID())
            Spacer()
            
            Button {
                withAnimation {
                    self.viewModel.mapViewModel.toggleUserTrackingMode()
                }
            } label: {
                Image(self.viewModel.mapViewModel.locationAllowed == false ? ImagesEnum.mapNotCenteredOnUser.rawValue : ImagesEnum.centerMapOnUserPin.rawValue)
                    .animation(.default, value: self.viewModel.mapViewModel.locationIsDisabled())
                    .id(UUID())
            }
            .buttonStyle(.simpleMapButton)
        }.padding(.vertical, 64)
            .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    var selectedScooterView: some View {
        if let selectedScooter = viewModel.selectedScooter {
            withAnimation {
                ScooterCardView(scooter: selectedScooter.scooterData, getLocationHandler: {
                    self.viewModel.goToScooterLocation()
                }, showSheet: {
                    self.viewModel.showUnlockingSheet = true
//                    self.mapCoordinatorViewModel.rideSheetState = .tripSummary
                    self.mapCoordinatorViewModel.sheetPresentationDetents = .none
                    
                })
                    .shadow(radius: 10)
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
    
    @ViewBuilder
    var sheetMode: some View {
        switch mapCoordinatorViewModel.rideSheetState {
        case .start:
            StartRideSheetView(scooter: self.mapCoordinatorViewModel.selectedScooter, onStartRide: {
                self.viewModel.startRide(scooter: self.mapCoordinatorViewModel.selectedScooter, completion: { response in
                    switch response {
                    case .success:
                        self.mapCoordinatorViewModel.rideSheetState = .detailsMinimized
                    case .failure(let error):
                        ErrorService().showError(message: ErrorService().getServerErrorMessage(error))
                        self.mapCoordinatorViewModel.sheetPresentationDetents = .none
                    }
                })
            })
        case .detailsMinimized:
            TripDetailsSheetView(scooter: mapCoordinatorViewModel.selectedScooter, mapCoordinatorViewModel: self.mapCoordinatorViewModel, endRide: {
                self.mapCoordinatorViewModel.sheetPresentationDetents = .full
                self.mapCoordinatorViewModel.rideSheetState = .tripSummary
                
            })
        case .tripSummary:
            TripSummaryView(mapImage: self.viewModel.mapViewModel.mapSnapshot, mapCoordinatorViewModel: mapCoordinatorViewModel, onPayment: {
                self.mapCoordinatorViewModel.sheetPresentationDetents = .none
                self.viewModel.mapViewModel.refreshScooterList()
            })
        }
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerScreen(mapCoordinatorViewModel: .init(), onGoValidateWithCode: {}, onGoToMenu: {})
            .ignoresSafeArea()
    }
}
