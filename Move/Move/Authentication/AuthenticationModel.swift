//
//  AuthenticationModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import Foundation

struct UserModel {
    var email: String = ""
    var username: String = ""
    var password: String = ""
}

class UserViewModel: ObservableObject {
    @Published var userModel = UserModel()
}
