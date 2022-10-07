//
//  ErrorService.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftMessages

class ErrorService {
    static let errorService = ErrorService()
    
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

        SwiftMessages.show(view: view)
    }
    
    func showErrorWithButton(message: String, title: String, completion:@escaping () -> Void) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(Theme.error)

        view.configureDropShadow()

        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(title: title, body: message, iconText: iconText)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.buttonTapHandler = { _ in SwiftMessages.hide()
            completion()
        }
        
        view.button?.setTitle("GO", for: .normal)
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        SwiftMessages.show(view: view)
    }
}
