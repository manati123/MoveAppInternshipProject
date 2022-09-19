//
//  Buttons.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        Text("f")
    }
}

struct FilledButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isEnabled ? Font.baiJamjuree.button1 : Font.baiJamjuree.body1)
            .padding(16)
            .background(isEnabled ?
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.accentPink)
                        ) :
                            AnyView(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.accentPink, lineWidth: 1)
                                    .foregroundColor(.clear)
                            ))
            .foregroundColor(isEnabled ? .neutralWhite : .neutralPurple)
    }
}

struct TransparentButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isEnabled ? Font.baiJamjuree.button1 : Font.baiJamjuree.body1)
            .padding(16)
            .background(isEnabled ?
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.accentPink, lineWidth: 1)
                                .foregroundColor(.clear)
                            
                        ) :
                            AnyView(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.neutralPurple, lineWidth: 1)
                                    .foregroundColor(.clear)
                                
                            ))
            .foregroundColor(isEnabled ? Color.accentPink : .neutralPurple)
            .frame(width:96, height: 56)
    }
}

struct TransparentWhiteButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.baiJamjuree.button1)
            .background(RoundedRectangle(cornerRadius: 16)
                .fill(Color.neutralWhite.opacity(0.2))
                .frame(width: 56, height: 56)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.neutralWhite, lineWidth: 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .foregroundColor(Color.neutralWhite)
            .frame(maxWidth: 56, maxHeight: 56)
            
    }
}

struct PinCodeButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.baiJamjuree.heading2)
            .frame(width:32,  height: 32)
            .padding(15)
            .foregroundColor(.black)
            .background( !configuration.isPressed ?
                RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.neutralGray) :
                RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.neutralWhite)
            )
    }
}

struct SimpleMapButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.neutralWhite)
                .shadow(radius: CGFloat(20))
            )
    }
}

extension ButtonStyle where Self == SimpleMapButton {
    static var simpleMapButton: Self {
        return .init()
    }
}

extension ButtonStyle where Self == FilledButton {
    static var filledButton: Self {
        return .init()
    }
}

extension ButtonStyle where Self == TransparentButton {
    static var transparentButton: Self {
        return .init()
    }
}

extension ButtonStyle where Self == TransparentWhiteButton {
    static var transparentWhiteButton: Self {
        return .init()
    }
}

extension ButtonStyle where Self == PinCodeButton {
    static var pinCodeButton: Self {
        return .init()
    }
}

//
//extension ButtonStyle where Self == ButtonWithIconAndBoldText {
//    static var buttonWithIconAndBoldText: Self {
//        return .init(icon: "")
//    }
//}

struct Buttons_Previews: PreviewProvider {
    @State var ab = "1"
    static var previews: some View {
        ZStack {
            //            Color.primaryPurple
            PurpleBackground()
            HStack {
//                TextField("", text: self.$ab)
            
                Button {
                    
                } label: {
                    //            Image("UserNotCenteredPin")
                    Text("")
                }
                Button {
                    
                } label: {
                    //            Image("UserNotCenteredPin")
                    Text("")
                }
                
                    Button {
                        
                    } label: {
                        //            Image("UserNotCenteredPin")
                        Text("")
                    }
            }
            .buttonStyle(.pinCodeButton)
        }
    }
}

