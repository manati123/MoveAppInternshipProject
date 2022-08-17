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
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AuthenticationView(), tag: .signUp, selection: $logState) {
                    EmptyView()
                }
            }
        }
    }
}

struct SingUpCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpCoordinatorView()
    }
}
