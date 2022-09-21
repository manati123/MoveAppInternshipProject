//
//  UnlockScooterSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 10.09.2022.
//

import SwiftUI

struct UnlockScooterSheetView: View {
    var scooter: Scooter
    let onGoValidateWithCode:() -> Void
    var body: some View {
        VStack(spacing: 20) {
            Text("You can unlock this scooter through these methods:")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
            HStack(alignment: .bottom) {
                
                leftSideData
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.30, alignment: .top)
                Spacer()
                    scooterImage
                
            }.padding(.horizontal,  20)
           bottomButtons
        }
    }
    
    var leftSideData: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Scooter")
                .font(Font.baiJamjuree.caption2)
                .foregroundColor(Color.primaryPurple)
            Text(verbatim: "#\(self.scooter.number!)")
                .font(Font.baiJamjuree.heading1)
                .foregroundColor(Color.primaryPurple)
            BatteryView(battery: self.scooter.battery!)
            HStack {
                Button() {
                    print("LMAO")
                } label: {
                    Image(ImagesEnum.ringScooterPin.rawValue)
                }
                .buttonStyle(.simpleMapButton)
                Text("Ring")
                    .font(Font.baiJamjuree.smallText)
                    .foregroundColor(Color.primaryPurple)
            }
            HStack {
                Button() {
                    print("LMAO")
                } label: {
                    Image(ImagesEnum.missingScooterPin.rawValue)
                }
                .buttonStyle(.simpleMapButton)
                Text("Missing")
                    .font(Font.baiJamjuree.smallText)
                    .foregroundColor(Color.primaryPurple)
            }
        }
    }
    
    var bottomButtons: some View {
        HStack(spacing: 21) {
            Spacer()
            Button() {
                print("LMAO")
            } label: {
                Text("NFC")
            }
            .buttonStyle(.transparentButton)
            
            Button() {
                print("LMAO")
            } label: {
//                    Image(ImagesEnum.missingScooterPin.rawValue)
                Text("QR")
            }
            .buttonStyle(.transparentButton)
            
            Button() {
                self.onGoValidateWithCode()
            } label: {
                Text("123")
            }
            .buttonStyle(.transparentButton)
            Spacer()
        }
    }
    
    var scooterImage: some View {
        Image(ImagesEnum.cardViewScooterRightOrientation.rawValue)
            .resizable()
            .scaledToFit()
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .background(RoundedRectangle(cornerRadius: 70)
                .foregroundColor(Color.neutralGray)
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .bottom)
                .offset(x: 0, y: 45)
                .opacity(0.15)
            )
            
    }
}

struct UnlockScooterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockScooterSheetView(scooter: Scooter(address: "skjdbfsdbfjs skdkjfbsdf skdfbksd sdkjfbks ksdjfb", _id: "", number: 1234, battery: 90, lockedStatus: true, bookStatus: "", createdAt: "", updatedAt: "", __v: 123), onGoValidateWithCode: {})
    }
}
