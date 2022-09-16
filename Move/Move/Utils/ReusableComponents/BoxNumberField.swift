//
//  BoxNumberField.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 12.09.2022.
//

import SwiftUI
import PasscodeField


struct BoxNumberField: View {
    var body: some View {
            PasscodeField("") { digits, action in
                if "1234" == digits.concat {
                    action(true)
                } else {
                    action(false)
                }
            }
            .foregroundColor(Color.black)

    }
}


struct BoxNumberField_Previews: PreviewProvider {
    static var previews: some View {
        BoxNumberField()
    }
}
