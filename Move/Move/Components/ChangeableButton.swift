//
//  ChangeableButton.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct ChangeableButton: View {
    var text = "Get started"
    var body: some View {
        Button {
            
        } label: {
            Text(text)
                .Button2()
                .foregroundColor(.white)
                .opacity(0.5)
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .clipShape(Capsule())
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("NextButtonColor"), lineWidth: 0.5)
            )
            
    }
}

struct ChangeableButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangeableButton()
    }
}
