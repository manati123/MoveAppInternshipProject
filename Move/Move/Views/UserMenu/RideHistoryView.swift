//
//  RideListView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

struct RideHistoryView: View {
    let rides: [RideInformation] = .init()
    let onGoBack:() -> Void
    var body: some View {
        VStack {
            TopBarWithBackAndIcon(text: "History", onGoBack: onGoBack, icon: "")
                .padding(.bottom, 44)
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<10, id: \.self) { _ in
                        RideInformationCard(ride: RideInformation(initialAddress: "Caminul 16 Hasdeu", finishAddress: "Str. Lunii 2A", distance: 4.2, time: "00:15 min"))
                    }
                }
                .padding(.top, 10)
            }
        }
    }
}

struct RideHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RideHistoryView(onGoBack: {})
    }
}
