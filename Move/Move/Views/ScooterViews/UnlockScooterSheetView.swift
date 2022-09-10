//
//  UnlockScooterSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 10.09.2022.
//

import SwiftUI

struct UnlockScooterSheetView: View {
    var body: some View {
        VStack {
            Text("You can unlock this scooter through these methods:")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
            HStack {
                
                VStack {
                    Text("1")
                    Text("2")
                    Text("3")
                    Text("4")
                }
                Spacer()
                    scooterImage
                
            }.padding(.horizontal,  20)
        }
    }
    
    var scooterImage: some View {
        Image(ImagesEnum.cardViewScooterRightOrientation.rawValue)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .background(RoundedRectangle(cornerRadius: 36)
                .foregroundColor(Color.neutralGray)
                .frame(width: UIScreen.main.bounds.height * 0.11, height: UIScreen.main.bounds.height * 0.1, alignment: .bottom)
                .offset(x: 0, y: 12)
                .opacity(0.2)
            )
    }
}

struct UnlockScooterSheetView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockScooterSheetView()
    }
}
