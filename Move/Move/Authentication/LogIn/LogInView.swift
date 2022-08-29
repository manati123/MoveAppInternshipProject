//
//  LogInView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import SwiftUI

struct LogInView: View {
    @StateObject var viewModel: UserViewModel
    var userAPI = AuthenticationAPI()
    let onFinished: () -> Void
    let onGoAuth: () -> Void
    let onForgotPassword: () -> Void
    var body: some View {
        ZStack {
            AuthenticationBackground()
            GeometryReader { geometry in
                ScrollView {
                VStack(alignment: .leading) {
                    Image("SmallLogoWhite")
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Login")
                            .font(Font.baiJamjuree.heading1)
                            .foregroundColor(.white)
                        Text("Enter your account credentials and start riding away")
                            .font(Font.baiJamjuree.heading2)
                            .foregroundColor(.white)
                            .opacity(0.3)
                        
                        VStack(spacing: 30) {
                            VStack(spacing: 20) {
                                FloatingTextField(title: "Email", isSecured: false, isPasswordField: false, text: $viewModel.user.email, icon: "")
                                FloatingTextField(title: "Password", isSecured: true, isPasswordField: true, text: $viewModel.user.password, icon: "eye-closed")
                                    .font(Font.baiJamjuree.caption2)
                            }
                            VStack(alignment: .leading, spacing: 40) {
                                Button {
                                    onForgotPassword()
                                }label: {
                                    Text("Forgot your password?")
                                        .underline()
                                        .font(Font.baiJamjuree.smallText)
                                        .foregroundColor(Color.neutralWhite)
                                        .accentColor(Color.neutralWhite)
                                }
                                Button() {
                                    userAPI.loginUser(user: viewModel.user)
                                    onFinished()
                                } label: {
                                    Text("Login")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.filledButton)
                                .disabled(viewModel.loginFieldsAreCorrect() ? false : true)
                                .animation(.default, value: viewModel.loginFieldsAreCorrect())
                                
                                HStack(spacing: 0) {
                                    Text("Don’t have an account? You can")
                                        .font(Font.baiJamjuree.smallText)
                                        .foregroundColor(Color.neutralWhite)
                                    Button{
                                        onGoAuth()
                                    }label: {
                                        Text(" start with one here")
                                            .underline()
                                            .font(Font.baiJamjuree.smallText)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.neutralWhite)
                                    }
                                }
                            }
                        }
                    }
                    }.padding()
                }
                
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(viewModel: UserViewModel(), onFinished: {}, onGoAuth: {}, onForgotPassword:  {})
    }
}
