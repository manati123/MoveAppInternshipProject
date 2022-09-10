//
//  AuthenticationBackground.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import Foundation
import SwiftUI
struct AuthenticationBackground: View {
    var body: some View {
        GeometryReader { g in
            VStack(spacing: 40) {
                HStack(spacing: 200) {
                    Spacer()
                    //                    Spacer()
                    RoundedRectangle(cornerRadius: 130)
                        .frame(width: g.size.width * 1, height: g.size.height * 0.5)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .rotationEffect(.degrees(-25))
                    
                }
                HStack(spacing: 200) {
                    
                    //                    Spacer()
                    RoundedRectangle(cornerRadius: 180)
                        .frame(width: g.size.width * 1, height: g.size.height * 0.5)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .rotationEffect(.degrees(5))
                        .offset(x: g.size.width / -2.5, y: 0)
                    Spacer()
                } .frame(maxWidth: UIScreen.main.bounds.width)
            }
            
        }.background(Color.primaryPurple)
            .ignoresSafeArea()
    }
}
