//
//  ScooterSerialNumberView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 12.09.2022.
//

import SwiftUI

struct ScooterSerialNumberView: View {
    
    let onGoBack:() -> Void
    let onGoToLoad:() -> Void
    @State var selectedScooter: Scooter
    var body: some View {
        
        ZStack {
            PurpleBackground()
            ScrollView {
                VStack(spacing: 24) {
                    topHeader
                    Spacer()
                    bodyInformation
                    
                    Spacer()
                    PasscodeFieldView(selectedScooterNumber: self.selectedScooter.number, goToLoad: onGoToLoad)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("Alternately you can unlock using")
                        .font(Font.baiJamjuree.heading3)
                        .fontWeight(.bold)
                    unlockAlternatives
                    Spacer()
                }.frame(minHeight: UIScreen.main.bounds.height)
                    .padding(.top, 54)
            }
            
        }.foregroundColor(.white)
    }
    
    var unlockAlternatives: some View {
        HStack(spacing: 21) {
            Button {
                
            }label: {
                Text("QR")
            }
            .buttonStyle(.transparentWhiteButton)
            
            Text("or")
                .font(Font.baiJamjuree.heading3)
                .fontWeight(.bold)
            Button {
                
            }label: {
                Text("NFC")
            }
            .buttonStyle(.transparentWhiteButton)
            
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
            Spacer()
        }.padding(.horizontal, 24)
    }
    
    var bodyInformation: some View {
        VStack(spacing: 24) {
            Text("Enter the scooter's serial number")
                .font(Font.baiJamjuree.heading1)
                .multilineTextAlignment(.center)
                .lineLimit(3)
            Text("You can find it on the scooter's front panel")
                .font(Font.baiJamjuree.heading4)
                .foregroundColor(Color.neutralGray)
                .padding(.horizontal, 60)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
    }
}

struct ScooterSerialNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterSerialNumberView(onGoBack: {}, onGoToLoad: {}, selectedScooter: .init())
    }
}
