//
//  MapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 30.08.2022.
//

import SwiftUI
import MapKit



struct MapView: View{
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapViewUIKIT()
            HStack {
                Button {
                    print("menu")
                } label: {
                    Image("GotoMenuPin")
                }
                .buttonStyle(.simpleMapButton)
                
                Spacer()
                
                Button {
                    print("center")
                } label: {
                    Image("CenteredOnUserPin")
                }
                .buttonStyle(.simpleMapButton)
            }.padding(.vertical, 64)
                .padding(.horizontal, 24)
                
            
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .ignoresSafeArea()
    }
}
