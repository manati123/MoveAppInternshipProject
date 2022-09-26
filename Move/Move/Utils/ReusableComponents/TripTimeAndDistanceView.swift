//
//  TripTimeAndDistanceView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.09.2022.
//

import SwiftUI

struct TripTimeAndDistanceView: View {
    @State var time = "00:12"
    @State var distance: Double = 0.0
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
                
                HStack(alignment: .bottom) {
                    TimerView(timerIsRunning: self.$timeIsRunning)
                    Text("min")
                        .font(Font.baiJamjuree.heading3)
                        .padding(.bottom, 2)
                }.foregroundColor(.primaryPurple)
            }
            VStack {
                HStack(spacing: 4) {
                    Image(systemName: "map")
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    Text("Distance")
                }
                HStack(alignment: .bottom) {
                    Text("\(self.distance, specifier: "%.1f")")
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
            .onAppear {
                incrementDistance()
            }
    }
    
    func incrementDistance() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.distance += 0.1
            incrementDistance()
        }
    }
        
}

struct TripTimeAndDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        TripTimeAndDistanceView(timeIsRunning: .constant(true))
    }
}
