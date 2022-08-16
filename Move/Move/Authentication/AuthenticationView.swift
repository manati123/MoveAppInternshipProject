//
//  AuthenticationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        ZStack {
            GeometryReader { g in
                HStack(spacing: 250) {
                    Image(systemName: "arrow.left")
//                    Spacer()
                RoundedRectangle(cornerRadius: 60)
                    .frame(width: g.size.width * 0.5, height: g.size.height * 0.25)
                    .foregroundColor(.white)
                    .opacity(0.1)
                    .rotationEffect(.degrees(-25))
                    
                }
                    
                VStack {
                    
                }
            }
        }
        .background(Color("SplashBackground"))
        .ignoresSafeArea()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
