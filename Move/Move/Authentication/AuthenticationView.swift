//
//  AuthenticationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI




struct AuthenticationView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            backgroundView
            GeometryReader { g in
                VStack(alignment: .leading){
                    Image("SmallLogoWhite")
                    //                    .offset(x: -155, y: 10)
                    VStack(alignment: .leading, spacing: 20) {
                        //                    Spacer()
                        Text("Let's get started")
                            .font(Font.baiJamjuree.heading1)
                            .foregroundColor(.white)
                        Text("Sign up or login and start riding right away")
                            .font(Font.baiJamjuree.heading2)
                            .foregroundColor(.white)
                            .opacity(0.3)
                        VStack(spacing: 30) {
                            
                            VStack {
                                FloatingTextField(title: "Email", text: $viewModel.email)
                                    .font(Font.baiJamjuree.caption2)
                                FloatingTextField(title: "Username", text: $viewModel.username)
                                    .font(Font.baiJamjuree.caption2)
                                FloatingTextField(title: "Password", text: $viewModel.password)
                                    .font(Font.baiJamjuree.caption2)
                            }
                            VStack(alignment: .leading, spacing: 2){
                                Text("By continuing you agree to Move's")
                                    .font(Font.baiJamjuree.smallText)
                                    .foregroundColor(.white)
                                termsAndConditions
                            }.frame(maxWidth: .infinity)
                            ChangeableButton()
                            logInText
                        }
                    }
                }.padding()
            }
        }
        
    }
    
    func validateEmail() -> Bool {
        if viewModel.email.count > 100 {
                return false
            }
            let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: viewModel.email)
    }
    
    func fieldAreCorrect() -> Bool {
        return validateEmail() && viewModel.username.count >= 3 && viewModel.password.count >= 9
    }
    
    var logInText: some View {
        HStack(spacing: 0) {
            Text("You already have an account? You can")
                .font(Font.baiJamjuree.smallText)
                .foregroundColor(.white)
            Button {
                print("LMAOCUAIE")
            } label: {
                Text(" log in here")
                    .underline()
                    .font(Font.baiJamjuree.smallText)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .accentColor(.white)
            }
        }
    }

    var termsAndConditions: some View {
        HStack(spacing: 0) {
            Text("[Terms and Conditions](https://tapptitude.com)")
                .underline()
                .font(Font.baiJamjuree.smallText)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .accentColor(.white)
            Text(" and ")
                .font(Font.baiJamjuree.smallText)
                .foregroundColor(.white)
            Text("[Privacy Policy](https://tapptitude.com)")
                .underline()
                .font(Font.baiJamjuree.smallText)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .accentColor(.white)
            
        }.padding(.trailing, 82).frame(maxWidth: .infinity)
        
    }

    var backgroundView: some View {
        GeometryReader { g in
            VStack(spacing: 40) {
                HStack(spacing: 200) {
                    Spacer()
                    //                    Spacer()
                    RoundedRectangle(cornerRadius: 130)
                        .frame(width: g.size.width * 1, height: g.size.height * 0.5)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .rotationEffect(.degrees(-25))
                    
                }
                HStack(spacing: 200) {
                    
                    //                    Spacer()
                    RoundedRectangle(cornerRadius: 180)
                        .frame(width: g.size.width * 1, height: g.size.height * 0.5)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .rotationEffect(.degrees(5))
                        .offset(x: g.size.width / -2.5, y: 0)
                    Spacer()
                } .frame(maxWidth: UIScreen.main.bounds.width)
            }
            
        }.background(Color("SplashBackground"))
            .ignoresSafeArea()
    }



}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
