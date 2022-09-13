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
    case account = "Account"
}

struct MapCoordinatorView: View {
    @State var mapState: MapCoordinatorStates? =  MapCoordinatorStates.mapView
    @ObservedObject var userViewModel: UserViewModel
    let logOut:() -> Void
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: MapContainerScreen(onGoToMenu: {self.mapState = .menu})
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .transition(.slide.animation(.default)),
                               tag: .mapView,
                               selection: $mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
                NavigationLink(destination: MainMenuView(userViewModel: userViewModel, onGoBack: {self.mapState = .mapView}, onGoToAccount: {self.mapState = .account})
                    .navigationBarHidden(true)
                    .transition(.slide.animation(.default)),
                               tag: .menu,
                               selection: $mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
                NavigationLink(destination: UserAccountView(userViewModel: userViewModel, onLogOut: {logOut()}, onGoBack: {self.mapState = .menu})
                    .navigationBarHidden(true)
                    .transition(.slide.animation(.default)),
                               tag: .account,
                               selection: $mapState
                ){
                    EmptyView()
                }.transition(.slide.animation(.default))
            }
            .navigationBarHidden(true)
        }
    }
}

struct MapCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
//        MapCoordinatorView(logOut: {}, onFinished: {})
        Text("f")
    }
}
