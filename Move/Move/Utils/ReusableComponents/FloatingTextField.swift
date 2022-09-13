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
    @State var isSecured = false
    @State var isPasswordField = false
    var foregroundColor: Color = .white
    var text: Binding<String>
    @State var icon: String = ""
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(foregroundColor)
                .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                .scaleEffect(isTouched ? 1 : 0.8, anchor: .leading)
                .opacity(0.5)
            switch self.isSecured{
            case true:
                ZStack{
                    VStack(alignment: .leading, spacing: 0) {
                        SecureField("", text: text)
                            .foregroundColor(foregroundColor)
                            .accentColor(foregroundColor)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                self.isTouched = true
                            }
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            .background(foregroundColor)
                            .opacity(isTouched ? 1 : 0.4)
                    }
                    Button {
                        isSecured.toggle()
                        if self.text.wrappedValue != "" {
                            self.icon = isSecured ? "eye-closed" : "eye-open"
                        }
                    }label: {
                        if self.text.wrappedValue != "" {
                            Image(self.icon)
                                .offset(x:0, y: -5)
                        }
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
            default:
                ZStack{
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        TextField("", text: text)
                            .foregroundColor(foregroundColor)
                            .accentColor(foregroundColor)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                self.isTouched = true
                            }
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                            .background(foregroundColor)
                            .opacity(isTouched ? 1 : 0.4)
                    }
                    
                    Button {
                        if isPasswordField {
                            isSecured.toggle()
                            if text.wrappedValue != "" {
                                self.icon = isSecured ? "eye-closed" : "eye-open"
                            }
                        }
                        else {
                            self.text.wrappedValue = ""
                            self.icon = ""
                        }
                    }label: {
                        if self.text.wrappedValue != "" {
                            Image(self.icon)
                                .renderingMode(.original)
                                .offset(x:0, y: -5)
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding(.top, 15)
        .animation(.spring(response: 0.2, dampingFraction: 0.5))
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    @State static var lmao = "cocos"
    static var previews: some View {
        FloatingTextField(title: "LMAO", isSecured: true, isPasswordField: true, text: $lmao, icon: "eye-closed" )
            .background(Color.primaryPurple)
        //        Color.red
    }
}
