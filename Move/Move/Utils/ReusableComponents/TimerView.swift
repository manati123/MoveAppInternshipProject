//
//  TimerView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.09.2022.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: ViewModel
    
//    @Binding var timerIsRunning: Bool
    init(timerIsRunning: Binding<Bool>, tripDetails: TripDetailsModel) {
//        self.timerIsRunning = timerIsRunning
//        self.tripDetails = tripDetails
        self._viewModel = StateObject(wrappedValue: ViewModel(timerIsRunning: timerIsRunning, tripDetails: tripDetails))
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(viewModel.tripDetails.time)
                .font(Font.baiJamjuree.heading1)
                .foregroundColor(Color.primaryPurple)
            Text(viewModel.hours != 0 ? "h" : "min")
                .font(Font.baiJamjuree.heading3)
                .padding(.bottom, 2)
        }.foregroundColor(.primaryPurple)
    }
    
}

extension TimerView {
    class ViewModel: ObservableObject {
        @Published var tripDetails: TripDetailsModel
        @Published var timerIsRunning: Binding<Bool>
        @Published var minutes = 0
        @Published var hours = 0
        
        init(timerIsRunning: Binding<Bool>, tripDetails: TripDetailsModel) {
            self.tripDetails = tripDetails
            self.timerIsRunning = Binding<Bool>.init(projectedValue: timerIsRunning.self)
            print(self.timerIsRunning)
            Timer.scheduledTimer(withTimeInterval: 60.0, repeats: timerIsRunning.wrappedValue) { [self] timer in
                if timerIsRunning.wrappedValue {
                    minutes += 1
                    if minutes == 60 {
                        hours += 1
                        minutes = 0
                    }
                    
                    var minStr = ""
                    var hourStr = ""
                    
                    if minutes / 10 == 0 {
                        minStr = "0\(minutes)"
                    } else {
                        minStr = "\(minutes)"
                    }
                    
                    if hours / 10 == 0 {
                        hourStr = "0\(hours)"
                    } else {
                        hourStr = "\(hours)"
                    }
                    self.tripDetails.time = "\(hourStr):\(minStr)"
                }
            }
            
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerIsRunning: .constant(true), tripDetails: TripDetailsModel(time: "00:00", distance: 0.0))
    }
}
