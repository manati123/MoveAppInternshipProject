//
//  AuthenticationModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    
}
