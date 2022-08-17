//
//  FloatingTextField.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                            .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
                            .opacity(0.5)
            switch self.title{
            case "Password":
                SecureField("", text: text)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .disableAutocorrection(true)
            default:
                TextField("", text: text)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .disableAutocorrection(true)
            }
            
                
                
            // give TextField an empty placeholder
        }
        .padding(.top, 15)
                .animation(.spring(response: 0.2, dampingFraction: 0.5))
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
//        FloatingTextField()
        Color.red
    }
}
