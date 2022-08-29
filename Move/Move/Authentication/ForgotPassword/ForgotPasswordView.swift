//
//  ForgotPasswordView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var emailAddress = ""
    @StateObject var viewModel: UserViewModel
    var onFinished: () -> Void
    var onGoBack: () -> Void
    var body: some View {
        ZStack {
            AuthenticationBackground()
            ScrollView{
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Button {
                            onGoBack()
                        }label: {
                            Image("arrow-back")
                        }
                        Spacer()
                    }
                    
                    Text("Forgot password")
                        .font(Font.baiJamjuree.heading1)
                        .foregroundColor(Color.neutralWhite)
                    Text("Enter the email address you’re using for your account bellow and we’ll send you a password reset link.")
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.neutralGray)
                    VStack(spacing: 52){
                        FloatingTextField(title: "Email Address", isSecured: false, isPasswordField: false, text: $viewModel.user.email, icon: "")
                        .foregroundColor(Color.neutralWhite)
                    
                    Button() {
                        onFinished()
                    } label: {
                        Text("Send reset link")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(viewModel.fieldsAreCorrect() ? false : true)
                    .animation(.default, value: viewModel.fieldsAreCorrect())
                    }
                    
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: UserViewModel(), onFinished: {}, onGoBack: {})
    }
}
