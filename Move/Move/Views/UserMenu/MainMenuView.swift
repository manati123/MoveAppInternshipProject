//
//  MainMenuView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var userViewModel: UserViewModel
    @StateObject var viewModel: ViewModel = .init()
    let onGoBack:() -> Void
    @State var numberOfRides = 0
    let onGoToAccount:() -> Void
    let onGoToHistory:() -> Void
    
    func setNumberOfRides() {
        AuthenticationAPI().getUser(token: UserDefaultsService().loadTokenFromDefaults()) { result in
            switch result {
            case .success(let user):
                self.userViewModel.user = user
                self.numberOfRides = user.numberOfRides ?? 0
//                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(ImagesEnum.scooterWithShadow.rawValue)
            VStack(spacing: 32) {
                TopBarWithBackAndIcon(text: "Hi \(userViewModel.sessionUser.user.name)!", onGoBack: onGoBack, icon: ImagesEnum.avatar.rawValue)
                PurpleBackgroundInformativeWithButton(headingTitle: "History", subtitle: "Total rides: \(self.numberOfRides)", buttonText: "See all", onButtonHandler: onGoToHistory)
                    .padding(.leading, 15)
                    .id(UUID())
                buttons
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                Spacer()
            }
            
        }
//        .onAppear {
//            self.viewModel.getRides() { value in
//                self.viewModel.numberOfRides = value
//                self.viewModel.objectWillChange.send()
//            }
//        }
    }
    
    var buttons: some View {
        VStack(alignment: .leading, spacing: 50) {
            BasicIconButton(iconName: "gear", buttonText: "General settings")
            
            Button{
                onGoToAccount()
            } label: {
                Text("Account")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            
            Button{
                if let url = URL(string: "https://www.tapptitude.com") {
                       UIApplication.shared.open(url)
                    }
            } label: {
                Text("Change passowrd")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            
            BasicIconButton(iconName: "flag", buttonText: "Legal")
            Button{
                if let url = URL(string: "https://tapptitude.com/") {
                       UIApplication.shared.open(url)
                    }
            } label: {
                Text("Terms and conditions")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            Button{
                if let url = URL(string: "https://www.tapptitude.com") {
                       UIApplication.shared.open(url)
                    }
            } label: {
                Text("Privacy policy")
                    .foregroundColor(Color.primaryPurple)
                    .font(Font.baiJamjuree.button2)
            }
            .padding(.leading, 75)
            BasicIconButton(iconName: "star", buttonText: "Rate Us")
        }
        .onAppear{
            self.setNumberOfRides()
        }
    }
}

//struct MainMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenuView(onGoBack: {})
//    }
//}
