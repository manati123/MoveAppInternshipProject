//
//  WaitingForValidationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.08.2022.
//

import SwiftUI



struct WaitingForValidationView: View {
    let onFinished:() -> Void
    var body: some View {
        ZStack {
            PurpleBackground()
            VStack(alignment: .center) {
                Text("We are currently verifying your driving license")
                    .font(Font.baiJamjuree.heading1)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.neutralWhite)
                ActivityIndicator(isAnimating: .constant(true), color: .white, style: .large)
                    
            }
            .padding(.leading, 28)
            .padding(.trailing, 29)
        }
    }
}

struct WaitingForValidationView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingForValidationView(onFinished: {})
    }
}
