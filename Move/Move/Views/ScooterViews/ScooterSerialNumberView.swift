//
//  ScooterSerialNumberView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 12.09.2022.
//

import SwiftUI

struct ScooterSerialNumberView: View {
    var body: some View {
        ZStack {
            PurpleBackground()
            VStack(spacing: 24) {
                HStack {
                    Button {
                        
                    }label: {
                        Image(ImagesEnum.xPinButton.rawValue)
                    }
                    Spacer()
                    Text("Enter serial number")
                        .font(Font.baiJamjuree.heading2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal, 24)
                Spacer()
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
                
                Spacer()
                BoxNumberField(handler: {_,_ in })
                    Spacer()
                    Text("Alternately you can unlock using")
                    .font(Font.baiJamjuree.heading3)
                    .fontWeight(.bold)
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
                Spacer()
            }
            
        }.foregroundColor(.white)
    }
}

struct ScooterSerialNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterSerialNumberView()
    }
}
