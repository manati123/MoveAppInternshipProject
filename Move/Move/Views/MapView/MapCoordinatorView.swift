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

class MapCoordinatorViewModel: ObservableObject {
    @Published var selectedScooter: Scooter = .init()
    @Published var mapState: MapCoordinatorStates? =  MapCoordinatorStates.mapView
    @Published var showStartRideSheet = false
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
                    self.viewModel.showStartRideSheet = true
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

