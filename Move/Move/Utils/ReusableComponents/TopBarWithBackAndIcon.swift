//
//  TopBarWithBackAndIcon.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct TopBarWithBackAndIcon: View {
    var userName: String
    var body: some View {
        HStack {
            
            Image(ImagesEnum.arrowBackBlue.rawValue)
            Spacer()
            Text("Hi \(userName)!")
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
        TopBarWithBackAndIcon(userName: "connor")
    }
}
