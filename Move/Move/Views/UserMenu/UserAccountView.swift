//
//  UserAccountView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 13.09.2022.
//

import SwiftUI

class UserAccountViewModel: ObservableObject {
    private var authenticationAPI: AuthenticationAPI = .init()
    private var userDefaultsService: UserDefaultsService = .init()
    
    
    func logOut(token: String) {
        authenticationAPI.logOut(token: token) { result in
            switch result {
            case .success:
                self.userDefaultsService.removeTokenFromDefaults()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct UserAccountView: View {
    @ObservedObject var userViewModel: UserViewModel
    @StateObject var viewModel: UserAccountViewModel = .init()
    let onLogOut:() -> Void
    let onGoBack:() -> Void
    var body: some View {
        VStack(spacing: 44) {
            TopBarWithBackAndIcon(text: "Account", onGoBack: self.onGoBack, icon: "")
            VStack(spacing: 28) {
                FloatingTextField(title: "Username", isTouched: false, isSecured: false, isPasswordField: false, foregroundColor: Color.black, text: $userViewModel.sessionUser.user.name, icon: "")
                
                FloatingTextField(title: "Email Address", isTouched: false, isSecured: false, isPasswordField: false, foregroundColor: Color.black, text: $userViewModel.sessionUser.user.email, icon: "")
            }.padding(.horizontal, 24)
            Spacer()
            Button {
                onLogOut()
                viewModel.logOut(token: userViewModel.sessionUser.token)
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
