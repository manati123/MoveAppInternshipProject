//
//  FloatingTextField.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    @State var isTouched = false
    var text: Binding<String>
    var body: some View {
        ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.white)
                    .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                    .scaleEffect(isTouched ? 1 : 0.8, anchor: .leading)
                    .opacity(0.5)
                switch self.title{
                case "Password":
                    VStack(alignment: .leading, spacing: 0) {
                        SecureField("", text: text)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                self.isTouched = true
                            }
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .opacity(0.4)
                    }
                default:
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("", text: text)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                self.isTouched = true
                            }
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .opacity(0.4)
                    }
                }
                
                
            }
            .padding(.top, 15)
            .animation(.spring(response: 0.2, dampingFraction: 0.5))
            
            // give TextField an empty placeholder
        
        
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        //        FloatingTextField()
        Color.red
    }
}
