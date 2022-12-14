//
//  AuthenticationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//
import Foundation
import SwiftUI
import SwiftMessages
struct AuthenticationView: View {
    @ObservedObject var viewModel: UserViewModel
    @State var waitingForResponse = false
    let onFinished: () -> Void
    let onGoLogIn:() -> Void
    
    var body: some View {
        ZStack {
            PurpleBackground()
            GeometryReader { g in
                ScrollView {
                    VStack(alignment: .leading){
                        Image(ImagesEnum.smallWhiteLogo.rawValue)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Let's get started")
                                .font(Font.baiJamjuree.heading1)
                                .foregroundColor(.white)
                            Text("Sign up or login and start riding right away")
                                .font(Font.baiJamjuree.heading2)
                                .foregroundColor(.white)
                                .opacity(0.3)
                            VStack(spacing: 30) {
                                textFields
                                termsAndConditions
                                Button() {
                                    self.waitingForResponse = true
                                    self.viewModel.authenticate(onSuccess: self.onFinished, waiting: {
                                        self.waitingForResponse = false
                                    })
                                } label: {
                                    Text("Get started!")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.filledButton)
                                .disabled(fieldsAreFilled() ? false : true)
                                .animation(.default, value: fieldsAreFilled())
                                ActivityIndicator(isAnimating: .constant(self.waitingForResponse), color: .white, style: .large)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                logInText
                                //                                Spacer()
                            }
                        }
                    }
                    .padding()
                    
                }
            }.onAppear {
                self.viewModel.user.password = ""
                self.viewModel.user.name = ""
                self.viewModel.user.email = ""
            }
        }
        
    }
    
    var textFields: some View {
        VStack(spacing: 20) {
            FloatingTextField(title: "Email", isSecured: false, isPasswordField: false, text: $viewModel.user.email, icon: ImagesEnum.clearTextFieldIcon.rawValue)
                .font(Font.baiJamjuree.caption2)
                .keyboardType(.emailAddress)
            FloatingTextField(title: "Username", isSecured: false, isPasswordField: false, text: $viewModel.user.name, icon: "")
                .font(Font.baiJamjuree.caption2)
            FloatingTextField(title: "Password", isSecured: true, isPasswordField: true, text: $viewModel.user.password, icon: ImagesEnum.closedEyeIcon.rawValue)
                .font(Font.baiJamjuree.caption2)
        }
    }
    
    
    var logInText: some View {
        VStack(spacing: 0) {
            Text("You already have an account? You can")
                .font(Font.baiJamjuree.smallText)
                .foregroundColor(.white)
                
            Button {
                self.onGoLogIn()
            }label: {
                Text(" log in here")
                    .underline()
                    .font(Font.baiJamjuree.smallText)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                   
            }
//            Spacer()
        }
            .accentColor(.white)
        
    }
    
    var termsAndConditions: some View {
        
        VStack(alignment: .leading, spacing: 2){
            Text("By continuing you agree to Move's")
                .font(Font.baiJamjuree.smallText)
                .foregroundColor(.white)
            
            HStack(spacing: 0) {
                Text("[Terms and Conditions](https://tapptitude.com)")
                    .underline()
                    .font(Font.baiJamjuree.smallText.bold())
                    
                +
                Text(" and ")
                    .foregroundColor(.neutralWhite)
                    .font(Font.baiJamjuree.smallText)
                +
                Text("[Privacy Policy](https://tapptitude.com)")
                    .underline()
                    .font(Font.baiJamjuree.smallText
                        .bold())
            }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity)
                .minimumScaleFactor(0.01)
                .navigationBarHidden(true)
                .accentColor(Color.neutralWhite)
            
        }.frame(maxWidth: .infinity)
        
    }
    
    func fieldsAreFilled() -> Bool {
        return self.viewModel.user.email != "" && self.viewModel.user.password != "" && self.viewModel.user.name != ""
    }
}

//
//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            AuthenticationView(viewModel: UserViewModel(userDefaultsService: .init()), onFinished: {})
//                .previewInterfaceOrientation(.portrait)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
//            AuthenticationView(viewModel: UserViewModel(userDefaultsService: .init()), onFinished: {})
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewInterfaceOrientation(.portrait)
//        }
//    }
//}
