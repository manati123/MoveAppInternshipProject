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
}
