//
//  MainMenuView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct MainMenuView: View {
    let onGoBack:() -> Void
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(ImagesEnum.scooterWithShadow.rawValue)
            VStack(spacing: 32) {
                TopBarWithBackAndIcon(userName: "Gioni", onGoBack: onGoBack)
//                Spacer()
                PurpleBackgroundInformativeWithButton(headingTitle: "History", subtitle: "Total rides: 12", buttonText: "See all", onButtonHandler: {})
                    .padding(.leading, 15)
                    
                    
//                Spacer()
                buttons
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                Spacer()
            }
            
        }
    }
    
    var buttons: some View {
        VStack(alignment: .leading, spacing: 50) {
            BasicIconButton(iconName: "gear", buttonText: "General settings")
                
            Button{
                
            } label: {
                Text("Account")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            Button{
                
            } label: {
                Text("Change passowrd")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            BasicIconButton(iconName: "flag", buttonText: "Legal")
            Button{
                
            } label: {
                Text("Terms and conditions")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            Button{
                
            } label: {
                Text("Privacy policy")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            BasicIconButton(iconName: "star", buttonText: "Rate Us")
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(onGoBack: {})
    }
}
