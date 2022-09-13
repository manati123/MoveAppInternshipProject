//
//  SingUpCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 17.08.2022.
//

import SwiftUI

enum LogState: String{
    case signUp = "Authentication"
    case logIn = "LogIn"
    case forgotPassword = "ForgotPassword"
}

struct SignUpCoordinatorView: View {
    @State var logState: LogState? = .signUp
    @ObservedObject var viewModel: UserViewModel
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AuthenticationView(viewModel: viewModel, onFinished: {
                    logState = .logIn
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .signUp, selection: $logState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                NavigationLink(destination: LogInView(userViewModel: viewModel, onFinished: {
                    onFinished()
                }, onGoAuth: {
                    logState = .signUp
                }, onForgotPassword:  {
                    logState = .forgotPassword
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .logIn, selection: $logState) {
                    EmptyView()
                }
                NavigationLink(destination: ForgotPasswordView(viewModel: viewModel, onFinished: {

                }, onGoBack: {
                    logState = .logIn
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .forgotPassword, selection: $logState) {
                    EmptyView()
                }
            }
        }
    }
}

//struct SingUpCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpCoordinatorView(onFinished: {})
//    }
//}
