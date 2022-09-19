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
}

struct MapCoordinatorView: View {
    @State var mapState: MapCoordinatorStates? =  MapCoordinatorStates.mapView
    @ObservedObject var userViewModel: UserViewModel
    let logOut:() -> Void
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: MapContainerScreen(onGoValidateWithCode: {self.mapState = .unlockWithCode}, onGoToMenu: {onFinished()})
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .mapView,
                               selection: $mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: ScooterSerialNumberView(onGoBack: {self.mapState = .mapView})
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .unlockWithCode,
                               selection: $mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
                
            }
            .navigationBarHidden(true)
        }
    }
}

