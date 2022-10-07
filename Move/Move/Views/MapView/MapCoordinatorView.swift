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
    case unlockWithQR = "QR"
    case success = "Success"
    case summary = "Summary"
}

enum RideSheetState: String {
    case start = "Start"
    case detailsMinimized = "DetailsMinimized"
    case tripSummary = "TripSummary"
}

class MapCoordinatorViewModel: ObservableObject {
    @Published var selectedScooter: Scooter = .init()
    @Published var rideSheetState: RideSheetState = .start
    @Published var sheetPresentationDetents: SheetDetents = .none
    @Published var tripDetails: TripDetailsModel = .init(battery: 100, time: "00:00", distance: 0.0)
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
                NavigationLink(destination: MapContainerScreen(mapCoordinatorViewModel: viewModel, onGoValidateWithCode: {self.viewModel.mapState = .unlockWithCode},onGoValidateWithQR: {self.viewModel.mapState = .unlockWithQR} , onGoToMenu: {
                        onFinished()
                    })
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
                
                NavigationLink(destination: UnlockQRCodeView(selectedScooter: self.viewModel.selectedScooter, onGoToLoad: {self.viewModel.mapState = .success}, onGoBack: {self.viewModel.mapState = .mapView})
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .unlockWithQR,
                               selection: $viewModel.mapState
                ) {
                    EmptyView()
                }
                
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
    

}

