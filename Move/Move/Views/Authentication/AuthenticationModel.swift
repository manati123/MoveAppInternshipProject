//
//  AuthenticationModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//
import SwiftUI
struct Profile {
    
}

extension Profile {
    struct ContentView: View {
        var body: some View {
            Text("F")
        }
    }
}

extension Profile {
    class ViewModel: ObservableObject {
        
    }
}

import Foundation
import SwiftMessages
class UserViewModel: ObservableObject {
    @Published var user: User = User(name: "", password: "", email: "")
    @Published var sessionUser: LoggedUser = LoggedUser(user: User(name: "", password: "", email: ""), token: "")
    var userDefaultsService: UserDefaultsService
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    func validateEmail() -> Bool {
        if self.user.email.count > 100 {
                return false
            }
            let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self.user.email)
    }
    
    func fieldsAreCorrect() -> Bool {
        return validateEmail() && self.user.name.count >= 3 && self.user.password.count >= 9
    }
    
    func loginFieldsAreCorrect() -> Bool {
        return validateEmail() && self.user.password.count >= 9
    }
    
    func fieldsAreLongEnoughSignUp() -> Bool {
        return self.user.name.count >= 3 && self.user.password.count >= 9
    }
    
    func fieldsNotEmptyLogin() -> Bool {
        return self.user.email.count != 0 && self.user.password.count != 0
    }
    
    func loginErrorHandling(error: Error) {
        var errorString = ""
        if self.user.password.count < 9 {
            errorString +=  "Password not long enough!\n"
        }
        if !self.validateEmail() {
            errorString += "Email is not valid!"
        }
        errorString += error.localizedDescription
        ErrorService().showError(message: errorString)
    }
    
    
    func saveUserToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.sessionUser)
            UserDefaults.standard.set(data, forKey: "LoggedUser")
        } catch {
            print("Unable to Encode LoggedUser (\(error))")
        }
    }
    
    //TODO: move this
    func signUpErrorHandling(error: Error) {
        var errorString = ""
        if !self.validateEmail() {
            errorString += "Email is not valid!"
        }
        errorString += getServerErrorMessage(error)
        ErrorService().showError(message: errorString)
    }
    
    func getServerErrorMessage(_ serverError : Error) -> String {
          let objectDescription = String(describing: serverError)
          let localizedDescription = serverError.localizedDescription
          if localizedDescription != "" {
             if localizedDescription.contains(objectDescription) {
                return localizedDescription
             }
             if !objectDescription.contains(localizedDescription) {
//                print(objectDescription + ": " + localizedDescription)
                 let startIndex = objectDescription.index(objectDescription.startIndex, offsetBy: 13)
                 let endIndex = objectDescription.index(objectDescription.endIndex, offsetBy: -3)
                 return (String(objectDescription[startIndex...endIndex]))
             }
          }
        return objectDescription
       }
    
    func authenticate(onSuccess:@escaping () -> Void) {
        AuthenticationAPI().registerUser(user: self.user, completionHandler: { result in
            switch result {
            case .success(let user):
                self.sessionUser.user = user.user
                onSuccess()
            case .failure(let error):
                self.signUpErrorHandling(error: error)
            }
        })
    }
    
    func login(waiting: @escaping () -> Void, success: @escaping () -> Void) {
        AuthenticationAPI.shareInstance.loginUser(user: self.user) { response in
            print(response)
            switch response {
            case .success(let user):
                self.sessionUser = user
                print(user.token)
                self.userDefaultsService.saveTokenToDefaults(token: user.token)
                success()
            case .failure(let error):
                self.loginErrorHandling(error: error)
            }
            waiting()
        }
        
    }
}
