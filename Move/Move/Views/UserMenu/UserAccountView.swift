//
//  UserAccountView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

struct UserAccountView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State var user2: User = .init(name: "gionutz", password: "SDKJFNSKF", email: "gionu@hatz.kelutzu")
    let onLogOut:() -> Void
    let onGoBack:() -> Void
    var body: some View {
        VStack(spacing: 44) {
            TopBarWithBackAndIcon(text: "Account", onGoBack: self.onGoBack)
            VStack(spacing: 28) {
                FloatingTextField(title: "Username", isTouched: false, isSecured: false, isPasswordField: false, foregroundColor: Color.black, text: $userViewModel.user.name, icon: "")
                
                FloatingTextField(title: "Email Address", isTouched: false, isSecured: false, isPasswordField: false, foregroundColor: Color.black, text: $userViewModel.user.email, icon: "")
            }.padding(.horizontal, 24)
            Spacer()
            Button {
                onLogOut()
            }label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color.neutralGray)
                    Text("Log out")
                        .foregroundColor(Color.accentPink)
                        .font(Font.baiJamjuree.button2)
                }
            }
            Button {
                print("jhs djfhs")
            }label: {
                Text("Save edits")
                    .foregroundColor(Color.neutralGray)
                    .font(Font.baiJamjuree.button2)
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.3)
            }
            .buttonStyle(.filledButton)
            .disabled(true)
            .padding(.bottom, 40)
            
        }
    }
}

//struct UserAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserAccountView(user: UserViewModel(), onGoBack: {})
//    }
//}
