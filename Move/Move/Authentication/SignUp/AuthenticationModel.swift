//
//  AuthenticationModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import Foundation
import SwiftMessages
class UserViewModel: ObservableObject {
    @Published var user = User(name: "", password: "", email: "")
    @Published var sessionUser = LoggedUser(user: User(name: "", password: "", email: ""), token: "")
 
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
    
    func convertUserToJSON() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(self.sessionUser)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "LoggedUser")

        } catch {
            print("Unable to Encode LoggedUser (\(error))")
        }
    }
    
    func showError(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning)

        view.configureDropShadow()

        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: "Something went wrong", body: message, iconText: iconText)
        view.button?.isHidden = true
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        // Show the message.
        SwiftMessages.show(view: view)
    }
    
}
