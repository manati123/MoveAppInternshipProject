//
//  PurpleBackgroundInformativeWithButton.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct PurpleBackgroundInformativeWithButton: View {
    @StateObject var viewModel: ViewModel
    let onButtonAction:() -> Void
    init(headingTitle: String, subtitle: String, buttonText: String, onButtonHandler: @escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(heading: headingTitle, sub: subtitle, btnText: buttonText))
        self.onButtonAction = onButtonHandler
    }
    var body: some View {
        
        HStack(spacing: 52) {
            VStack(alignment: .leading) {
                Text(self.viewModel.headingTitle)
                    .font(Font.baiJamjuree.heading2)
                    .foregroundColor(Color.neutralWhite)
                Text(self.viewModel.subtitle)
                    .foregroundColor(Color.neutralGray)
            }.frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.16)
                .offset(x: 0, y: -5)
            
            
            Button {
                onButtonAction()
            }label: {
                HStack(spacing: 3) {
                    Text(self.viewModel.buttonText)
                        .font(Font.baiJamjuree.button1)
                    Image(ImagesEnum.arrowBack.rawValue)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }.buttonStyle(.filledButton)
                .offset(x: 0, y: -5)
        }.background(
            Image(ImagesEnum.menuHighlightBackground.rawValue)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
        )
        
    }
}

extension PurpleBackgroundInformativeWithButton {
    class ViewModel: ObservableObject {
        let headingTitle: String
        let subtitle: String
        let buttonText: String
        
        init(heading: String, sub: String, btnText: String) {
            headingTitle = heading
            subtitle = sub
            buttonText = btnText
        }
    }
}

struct PurpleBackgroundInformativeWithButton_Previews: PreviewProvider {
    static var previews: some View {
        PurpleBackgroundInformativeWithButton(headingTitle: "History", subtitle: "Total rides: 12", buttonText: "See all", onButtonHandler: {})
    }
}
