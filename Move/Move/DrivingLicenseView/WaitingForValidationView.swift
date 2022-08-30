//
//  WaitingForValidationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.08.2022.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    var color: UIColor
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct WaitingForValidationView: View {
    let onFinished:() -> Void
    var body: some View {
        ZStack {
            AuthenticationBackground()
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
