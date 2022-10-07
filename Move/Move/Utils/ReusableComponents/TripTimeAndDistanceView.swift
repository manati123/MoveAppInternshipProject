//
//  TripTimeAndDistanceView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.09.2022.
//

import SwiftUI

struct TripDetailsModel {
    var battery: Int
    var time: String
    var distance: Double
}

struct TripTimeAndDistanceView: View {
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    @Binding var timeIsRunning: Bool {
        didSet {
            print(timeIsRunning)
        }
    }
    var body: some View {
        HStack(spacing: 55) {
            VStack {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    Text("Travel time")
                }
                .padding(.trailing, 30)
                
                TimerView(timerIsRunning: self.$timeIsRunning, tripDetails: mapCoordinatorViewModel.tripDetails)
            }
            VStack {
                HStack(spacing: 4) {
                    Image(systemName: "map")
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    Text("Distance")
                }
                HStack(alignment: .bottom) {
                    Text("\(self.mapCoordinatorViewModel.tripDetails.distance, specifier: "%.1f")")
                        .font(Font.baiJamjuree.heading1)
                        .animation(.none)
                    Text("km")
                        .font(Font.baiJamjuree.heading3)
                        .padding(.bottom, 2)
                }.foregroundColor(.primaryPurple)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color.neutralGray)
            .font(Font.baiJamjuree.caption1)
            .padding(.leading, 24)
            .padding(.trailing, 83)
            .padding(.bottom, 36)
            
    }
}
