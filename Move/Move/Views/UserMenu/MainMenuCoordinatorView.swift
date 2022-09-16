//
//  MainMenuCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.09.2022.
//

import SwiftUI

enum MainMenuCoordinatorState: String {
    case menu = "Menu"
    case rides = "Rides"
    case account = "Account"
    case password = "Password"
}

struct MainMenuCoordinatorView: View {
    @State var menuState: MainMenuCoordinatorState? = .menu
    @ObservedObject var userViewModel: UserViewModel
    let logOut:() -> Void
    let onGoBack:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink(destination: MainMenuView(userViewModel: userViewModel, onGoBack: onGoBack, onGoToAccount: {menuState = .account}).navigationBarHidden(true).transition(.slide.animation(.default)), tag: MainMenuCoordinatorState.menu, selection: $menuState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: UserAccountView(userViewModel: userViewModel, onLogOut: logOut, onGoBack: {self.menuState = .menu}).navigationBarHidden(true).transition(.slide.animation(.default)), tag: MainMenuCoordinatorState.account, selection: $menuState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
//                NavigationLink(destination: LogInView(userViewModel: viewModel ,onFinished: {
//                    onFinished()
//                }, onGoAuth: {
//                    logState = .signUp
//                }, onForgotPassword:  {
//                    logState = .forgotPassword
//                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .logIn, selection: $logState) {
//                    EmptyView()
//                }
//                NavigationLink(destination: ForgotPasswordView(viewModel: viewModel, onFinished: {
//
//                }, onGoBack: {
//                    logState = .logIn
//                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .forgotPassword, selection: $logState) {
//                    EmptyView()
//                }
            }
        }

    }
}

//struct MainMenuCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenuCoordinatorView()
//    }
//}
