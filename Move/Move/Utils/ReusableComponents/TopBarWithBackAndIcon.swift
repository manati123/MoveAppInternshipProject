//
//  TopBarWithBackAndIcon.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct TopBarWithBackAndIcon: View {
    var text: String
    let onGoBack:() -> Void
    var body: some View {
        HStack {
            Button {
                onGoBack()
            }label: {
                Image(ImagesEnum.arrowBackBlue.rawValue)
            }
            Spacer()
            Text("\(text)")
                .font(Font.baiJamjuree.heading3)
                .foregroundColor(Color.primaryPurple)
            Spacer()
            Image(ImagesEnum.avatar.rawValue)
                .renderingMode(.original)
        }.frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
    }
}

struct TopBarWithBackAndIcon_Previews: PreviewProvider {
    static var previews: some View {
//        TopBarWithBackAndIcon(userName: "connor")
        Text("F")
    }
}
