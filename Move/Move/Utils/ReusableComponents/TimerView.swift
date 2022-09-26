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
    init(timerIsRunning: Binding<Bool>) {
//        self.timerIsRunning = timerIsRunning
        self._viewModel = StateObject(wrappedValue: ViewModel(timerIsRunning: timerIsRunning))
    }
    
    var body: some View {
        Text(viewModel.displayedTime)
            .font(Font.baiJamjuree.heading1)
            .foregroundColor(Color.primaryPurple)
    }
    
}

extension TimerView {
    class ViewModel: ObservableObject {
        @Published var timerIsRunning: Binding<Bool>
        @Published var displayedTime = "00:00"
        @Published var minutes = 0
        @Published var hours = 0
        
        init(timerIsRunning: Binding<Bool>) {
            self.timerIsRunning = Binding<Bool>.init(projectedValue: timerIsRunning.self)
            print(self.timerIsRunning)
            Timer.scheduledTimer(withTimeInterval: 60.0, repeats: timerIsRunning.wrappedValue) { [self] timer in
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
                displayedTime = "\(hourStr):\(minStr)"
            }
            
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerIsRunning: .constant(true))
    }
}
