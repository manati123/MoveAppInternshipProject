//
//  BasicIconButton.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct BasicIconButton: View {
    var iconName: String
    var buttonText: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .foregroundColor(Color.accentPink)
            Text(buttonText)
                .font(Font.baiJamjuree.button1)
                .foregroundColor(Color.primaryPurple)
        }.padding(.leading, 24)
    }
}

struct BasicIconButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicIconButton(iconName: "flag", buttonText: "General Settings")
    }
}
