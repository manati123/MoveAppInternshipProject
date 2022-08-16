//
//  SlideIndicatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI

struct StepIndicatorView: View {
    
    let numberOfSteps: Int
    var currentStepIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSteps) { index in
                Capsule()
                    .fill(index == currentStepIndex ? Color.gray : Color.black)
                    .frame(width: index == currentStepIndex ? 16: 4, height: 4)
                    .animation(.default)
            }
        }
    }
}
