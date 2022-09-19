//
//  PasscodeFieldTextBox.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 19.09.2022.
//

import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}

struct PasscodeFieldTextBox: View {
    @State var isHighlighted = false
    var id = UUID()
    @Binding var currentValue: String
    @FocusState var focusedFieldIndex: Int?
    var index: Int
    
//    init(currentValue: Binding<String>, index: Int, focusedFieldIndex: Int?) {
//        self._currentValue = currentValue
//        self._focusedFieldIndex = focusedFieldIndex
//        self.index = index
//    }
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField(" ", text: $currentValue.max(1), onEditingChanged: { editingChanged in
                if editingChanged {
                    self.isHighlighted = true
                } else {
                    self.isHighlighted = false
                }
                
            })
            .focused($focusedFieldIndex, equals: index)
                .font(Font.baiJamjuree.heading2)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .frame(width:32,  height: 32, alignment: .center)
                .accentColor(Color.accentPink)
                .padding(15)
                .foregroundColor(.black)
                .background( checkTextfieldStatus() ?
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.neutralWhite) :
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.neutralGray)
                             )
        }
    }
    
    
    func checkTextfieldStatus() -> Bool {
        return self.currentValue != "" || self.isHighlighted
    }
    
    func checkValueNotEmpty() -> Bool {
        return self.currentValue.count == 1
    }
    
}

struct PasscodeFieldTextBox_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .center) {
            PurpleBackground()
//            PasscodeFieldTextBox(positionInPin: 0, currentValue: .constant("0"), onNumberInserted: {})
        }
    }
}
