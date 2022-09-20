//
//  UnlockQRCodeView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 20.09.2022.
//

import SwiftUI

struct UnlockQRCodeView: View {
    let onGoBack:() -> Void
    
    var body: some View {
        ZStack {
            PurpleBackground()
            VStack {
                topHeader
                screenInformation
                centerRoundedRectangle
                bottomSideAlternatives
            }
            .frame(maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
    var topHeader: some View {
        HStack {
            Button {
                onGoBack()
            }label: {
                Image(ImagesEnum.xPinButton.rawValue)
            }
            Spacer()
            Text("Enter serial number")
                .font(Font.baiJamjuree.heading2)
                .fontWeight(.bold)
                .foregroundColor(Color.neutralWhite)
            Spacer()
            Image(ImagesEnum.lightbulb.rawValue)
        }.padding(.horizontal, 24)
            .padding(.top, 54)
    }
    
    var screenInformation: some View {
        VStack(spacing: 16) {
            Text("Scan QR")
                .font(Font.baiJamjuree.heading1)
                .foregroundColor(Color.neutralWhite)
            Text("You can find it on the scooter's front panel")
                .font(Font.baiJamjuree.caption1)
                .foregroundColor(Color.neutralGray)
        }
        .multilineTextAlignment(.center)
        .padding(.top, 55)
        .padding(.horizontal, 80)
    }
    
    var centerRoundedRectangle: some View {
        RoundedRectangle(cornerRadius: 26)
            .stroke(Color.neutralWhite, lineWidth: 2)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.25)
            .padding(.top, 60)
    }
    
    var bottomSideAlternatives: some View {
        VStack(spacing: 24) {
            Text("Alternately you can unlock using")
                .font(Font.baiJamjuree.caption1)
                .foregroundColor(Color.neutralWhite)
            HStack(spacing: 21) {
                Button {
                    
                }label: {
                    Text("123")
                }
                .buttonStyle(.transparentWhiteButton)
                
                Text("or")
                    .font(Font.baiJamjuree.heading3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.neutralWhite)
                Button {
                    
                }label: {
                    Text("NFC")
                }
                .buttonStyle(.transparentWhiteButton)
                
            }
        }.padding(.top, 72)
            .padding(.bottom, 120)
    }
}

struct UnlockQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockQRCodeView(onGoBack: {})
    }
}
