//
//  MapCoordinatorView.swift
//  Move
//
//  Created by Silviu Preoteasa on 05.09.2022.
//

import SwiftUI

enum MapCoordinatorStates: String {
    case mapView = "MapView"
    case menu = "Menu"
    case unlockWithCode = "Code"
    case success = "Success"
}

enum RideSheetState: String {
    case start = "Start"
    case detailsMinimized = "DetailsMinimized"
}

class MapCoordinatorViewModel: ObservableObject {
    @Published var selectedScooter: Scooter = .init()
    @Published var rideSheetState: RideSheetState = .start
    @Published var sheetPresentationDetents: SheetDetents = .none
    @Published var mapState: MapCoordinatorStates? =  MapCoordinatorStates.mapView
    @Published var showStartRideSheet = false  {
        didSet {
            print("VALUE OF showStartRideSheet: BOOL IS \(showStartRideSheet)")
        }
    }
}

struct MapCoordinatorView: View {
    
    @StateObject var viewModel: MapCoordinatorViewModel = .init()
    @ObservedObject var userViewModel: UserViewModel
    let logOut:() -> Void
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                    NavigationLink(destination: MapContainerScreen(mapCoordinatorViewModel: viewModel, onGoValidateWithCode: {self.viewModel.mapState = .unlockWithCode}, onGoToMenu: {onFinished()})
//                        .overlay(
//                            FlexibleSheet(sheetDetents: .constant(self.viewModel.sheetPresentationDetents)) {
//                                
//                                sheetMode
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                    .background(Color.neutralWhite)
//                                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
//                            }
//                        )
                        .navigationBarHidden(true)
                        .ignoresSafeArea()
                        .transition(.slide.animation(.default)),
                                   tag: .mapView,
                                   selection: $viewModel.mapState
                    ){
                        EmptyView()
                    }.transition(.slide.animation(.default))
                    
                NavigationLink(destination: ScooterSerialNumberView(onGoBack: {self.viewModel.mapState = .mapView}, onGoToLoad: {self.viewModel.mapState = .success}, selectedScooter: self.viewModel.selectedScooter)
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .unlockWithCode,
                               selection: $viewModel.mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                
                NavigationLink(destination: UnlockSuccessfull(goToStartRide: {
                    self.viewModel.mapState = .mapView
//                    self.viewModel.showStartRideSheet = true
                    self.viewModel.sheetPresentationDetents = .third
                })
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .success,
                               selection: $viewModel.mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
            }
            .navigationBarHidden(true)
        }
    }
    
    //TODO: move this into MapContainerScreen to gain access to user location
    
    @ViewBuilder
    var sheetMode: some View {
        switch viewModel.rideSheetState {
        case .start:
            StartRideSheetView(scooter: self.viewModel.selectedScooter, onStartRide: {
                print("STARTING RIDE")
//                self.viewModel.sheetPresentationDetents = .none
                self.viewModel.rideSheetState = .detailsMinimized
            })
        case .detailsMinimized:
            TripDetailsSheetView(scooter: viewModel.selectedScooter)
        
        }
        
    }
}

