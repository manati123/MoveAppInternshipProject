//
//  MapCoordinatorView.swift
//  Move
//
//  Created by Silviu Preoteasa on 05.09.2022.
//

import SwiftUI

enum MapCoordinatorStates: String {
    case mapView = "MapView"
}

struct MapCoordinatorView: View {
    @State var mapState: MapCoordinatorStates? =  MapCoordinatorStates.mapView
    let logOut:() -> Void
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: MapContainerScreen()
                    .navigationBarHidden(true)
                    .transition(.slide.animation(.default)),
                               tag: .mapView,
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
        MapCoordinatorView(logOut: {}, onFinished: {})
    }
}
