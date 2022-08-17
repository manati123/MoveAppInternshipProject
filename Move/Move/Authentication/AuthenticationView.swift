//
//  AuthenticationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI




struct AuthenticationView: View {
    @StateObject var viewModel = UserViewModel()
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
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
                            .font(.custom("BaiJamjuree-Bold", size: 32))
                            .foregroundColor(.white)
                        Text("Sign up or login and start riding right away")
                            .font(.custom("BaiJamjuree-Regular", size: 28))
                            .foregroundColor(.white)
                            .opacity(0.3)
                        VStack(spacing: 30) {
                            
                            VStack {
                                FloatingTextField(title: "Email", text: $email)
                                    .font(.custom("BaiJamjuree-Regular", size: 22))
                                Divider()
                                    .frame(height: 1)
                                    .padding(.horizontal, 10)
                                    .background(Color.white)
                                    .opacity(0.4)
                            }
                            VStack {
                                FloatingTextField(title: "Username", text: $username)
                                    .font(.custom("BaiJamjuree-Regular", size: 22))
                                Divider()
                                    .frame(height: 1)
                                    .padding(.horizontal, 10)
                                    .background(Color.white)
                                    .opacity(0.4)
                            }
                            VStack {
                                FloatingTextField(title: "Password", text: $password)
                                    .font(.custom("BaiJamjuree-Regular", size: 22))
                                Divider()
                                    .frame(height: 1)
                                    .padding(.horizontal, 10)
                                    .background(Color.white)
                                    .opacity(0.4)
                            }
                            
                            Text("By continuing you agree to Move's Terms and Conditions and Privacy Policy")
                                .frame(alignment: .leading)
                            
                            ChangeableButton()
                        }
                    }
                }.padding()
            }
        }
        
    }
    
    var backgroundView: some View {
        GeometryReader { g in
            VStack {
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
                    RoundedRectangle(cornerRadius: 130)
                        .frame(width: g.size.width * 1, height: g.size.height * 0.5)
                        .foregroundColor(.white)
                        .opacity(0.1)
                        .rotationEffect(.degrees(-25))
                    Spacer()
                    
                }
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
