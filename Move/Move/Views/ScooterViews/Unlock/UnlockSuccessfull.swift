//
//  UnlockSuccessfull.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 19.09.2022.
//

import SwiftUI

struct UnlockSuccessfull: View {
    var body: some View {
        ZStack {
            PurpleBackground()
            VStack {
                Text("Unlock succesful")
                    .font(Font.baiJamjuree.heading1)
                    .foregroundColor(Color.neutralWhite)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 102)
                    .padding(.horizontal, 65)
//                    .padding(.top, 133)
                Image(ImagesEnum.bigCheckmark.rawValue)
                Text("Please respect all the driving regulations and other participants in traffic while using our scooters")
                    .font(Font.baiJamjuree.caption1)
                    .foregroundColor(Color.neutralGray)
                    .lineLimit(nil)
                    .padding(36)
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct UnlockSuccessfull_Previews: PreviewProvider {
    static var previews: some View {
        UnlockSuccessfull()
    }
}
