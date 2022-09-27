//
//  RideListView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

struct RideHistoryView: View {
    @State var rides: [RideInformation] = .init()
    
    let onGoBack:() -> Void
    @State var numberOfRides = 10
    @State var dragged = false
    var body: some View {
        VStack {
            TopBarWithBackAndIcon(text: "History", onGoBack: onGoBack, icon: "")
                .padding(.bottom, 44)
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    print("haha")
                    if !dragged {
                        self.numberOfRides = 0
                    } else {
                        self.numberOfRides = 10
                    }
                    dragged.toggle()
                    }
                LazyVStack(spacing: 12) {
                    ForEach(0..<self.numberOfRides, id: \.self) { _ in
                        RideInformationCard(ride: RideInformation(initialAddress: "Caminul 16 Hasdeu", finishAddress: "Str. Lunii 2A", distance: 4.2, time: "00:15 min"))
                    }
                }
                .padding(.top, 10)
            }.coordinateSpace(name: "pullToRefresh")
        }
    }
}

struct RideHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RideHistoryView(onGoBack: {})
    }
}
