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

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Button("QweqwE") {
            
        }
        .buttonStyle(.filledButton)
        .disabled(true)
    }
}

