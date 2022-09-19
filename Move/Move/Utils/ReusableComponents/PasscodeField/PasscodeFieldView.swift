//
//  PasscodeFieldView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 19.09.2022.
//

import SwiftUI
import Foundation

class PasscodeFieldViewModel: ObservableObject {
    @Published var currentPin = ["", "", "", ""]
    @FocusState var fieldFocusedState: Int?
    let correctPin: String
    
    init(correctPin: String) {
        self.correctPin = correctPin
    }
    
    func enteredPinIsCorrect() -> Bool {
        let currentPinConcatenated = self.currentPin.joined()
        return correctPin == currentPinConcatenated
    }
}

struct PasscodeFieldView: View {
    @State var currentPin = ["", "", "", ""]
    @FocusState var fieldFocusedState: Int?
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    PasscodeFieldTextBox(currentValue: $currentPin[index], focusedFieldIndex: _fieldFocusedState, index: index)
                        .onChange(of: currentPin[index]) { newValue in
                            if let fieldFocusedState = fieldFocusedState {
                                if newValue == "" {
                                    self.fieldFocusedState = fieldFocusedState - 1
                                } else {
                                    self.fieldFocusedState = fieldFocusedState + 1
                                }
                            } else {
                                self.fieldFocusedState = 0
                            }
                        }
                }
            }
        }
    }
}

struct PasscodeFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PurpleBackground()
            PasscodeFieldView()
            //            Text("ff")
            
        }
    }
}
