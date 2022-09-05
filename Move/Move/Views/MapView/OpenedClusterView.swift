//
//  OpenedClusterView.swift
//  Move
//
//  Created by Silviu Preoteasa on 05.09.2022.
//

import SwiftUI

struct OpenedClusterView: View {
    @State var scooters = [ScooterCardView(),ScooterCardView(),ScooterCardView(),ScooterCardView(),ScooterCardView()]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(scooters, id: \.id) { scooter in
                    scooter
                }
            }
        }
    }
}

struct OpenedClusterView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedClusterView()
    }
}
