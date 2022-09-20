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
    var selectedScooterNumber: Int?
    let goToLoad:() -> Void
    
    init(correctPin: Int?, goToLoad:@escaping ()->Void) {
        self.selectedScooterNumber = correctPin
        self.goToLoad = goToLoad
    }
    
    func enteredPinIsCorrect() -> Bool {
        let currentPinConcatenated = self.currentPin.joined()
        return selectedScooterNumber == Int(currentPinConcatenated)
    }
    
    func checkAllPinsAreFilled() -> Bool{
        for pin in currentPin {
            if pin == "" {
                return false
            }
        }
        return true
    }
    
    func checkAll() {
        if checkAllPinsAreFilled() {
            if enteredPinIsCorrect() {
                self.goToLoad()
            }
            else {
                ErrorService().showError(message: "Entered pin does not conform to the one on the selected scooter. Please try again")
                self.currentPin = ["", "", "", ""]
            }
        }
    }
}

struct PasscodeFieldView: View {
    @FocusState var fieldFocusedState: Int?
    @StateObject var viewModel: PasscodeFieldViewModel
    
    init(selectedScooterNumber: Int?, goToLoad:@escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: PasscodeFieldViewModel(correctPin: selectedScooterNumber, goToLoad: goToLoad))
    }
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    PasscodeFieldTextBox(currentValue: $viewModel.currentPin[index], focusedFieldIndex: _fieldFocusedState, index: index)
                        .onChange(of: viewModel.currentPin[index]) { newValue in
                            if let fieldFocusedState = fieldFocusedState {
                                if newValue == "" {
                                    self.fieldFocusedState = fieldFocusedState - 1
                                } else {
                                    self.fieldFocusedState = fieldFocusedState + 1
                                }
                            } else {
                                self.fieldFocusedState = 0
                            }
                            self.viewModel.checkAll()
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
//            PasscodeFieldView()
            //            Text("ff")
            
        }
    }
}
