//
//  LogInView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import SwiftUI

extension LogInView {
    class ViewModel : ObservableObject {
        @Published var error: String = ""
        @Published var showError: Bool = false
        @Published var waitingForResponse: Bool = false
        
        func onLogInSuccessfull() {
            
        }
        
    }
    private enum Field: Int, CaseIterable {
           case email, password
       }

}


struct LogInView: View {
    //TODO: go back to injection
    @ObservedObject var userViewModel: UserViewModel
    @StateObject private var viewModel = ViewModel()
    @FocusState private var fieldFocusedState: Field?
    let onFinished: () -> Void
    let onGoAuth: () -> Void
    let onForgotPassword: () -> Void
    var body: some View {
        ZStack {
            PurpleBackground()
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        Image(ImagesEnum.smallWhiteLogo.rawValue)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Login")
                                .font(Font.baiJamjuree.heading1)
                                .foregroundColor(.white)
                            Text("Enter your account credentials and start riding away")
                                .font(Font.baiJamjuree.heading2)
                                .foregroundColor(.white)
                                .opacity(0.3)
                            
                            VStack(spacing: 30) {
                                textFields
                                bottomSide
                            }
                        }
                    }.padding()
                }
                
            }
        }
    }
    
    var bottomSide: some View {
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
                callLogin()
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
            .disabled(userViewModel.fieldsNotEmptyLogin() ? false : true)
            .animation(.default, value: userViewModel.fieldsNotEmptyLogin())
            
            ActivityIndicator(isAnimating: .constant(self.viewModel.waitingForResponse), color: .white, style: .large)
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Spacer()
                noAccount
                Spacer()
            }
        }
    }
    
    
    //TODO: change 
    var noAccount: some View {
        VStack(spacing: 0) {
            
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
    
    var textFields: some View {
        VStack(spacing: 20) {
            FloatingTextField(title: "Email", isSecured: false, isPasswordField: false, text: $userViewModel.user.email, icon: "")
                .keyboardType(.emailAddress)
                .focused($fieldFocusedState, equals: .email)
            FloatingTextField(title: "Password", isSecured: true, isPasswordField: true, text: $userViewModel.user.password, icon: ImagesEnum.closedEyeIcon.rawValue)
                .font(Font.baiJamjuree.caption2)
                .focused($fieldFocusedState, equals: .password)
        }
    }
    
    func callLogin() {
        self.viewModel.waitingForResponse = true
        self.fieldFocusedState = nil
        self.userViewModel.login(waiting: {
            self.viewModel.waitingForResponse = false
        }, success: onFinished)
    }
}
