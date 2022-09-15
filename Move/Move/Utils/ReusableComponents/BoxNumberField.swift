//
//  BoxNumberField.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 12.09.2022.
//

import SwiftUI

struct BoxNumberField: View {
    var maxDigits = 4
    @State var pin = "1234"
    @State var isDisabled = false
    @State var showPin = true
    
    var handler: (String, (Bool) -> Void) -> Void
    var body: some View {
        ZStack {
         pinDots
            backgroundField
        }
    }
    
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0..<maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                    .frame(width: 52, height: 52)
                Spacer()
            }
        }
    }
    
    
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
                    self.pin = newValue
                    self.submitPin()
                })
                
                return TextField("", text: boundPin, onCommit: submitPin)
              
              // Introspect library can used to make the textField become first resonder on appearing
              // if you decide to add the pod 'Introspect' and import it, comment #50 to #53 and uncomment #55 to #61
              
                   .accentColor(.clear)
                   .foregroundColor(.clear)
                   .keyboardType(.numberPad)
                   .disabled(isDisabled)
    }
    
    private func submitPin() {
            guard !pin.isEmpty else {
                showPin = false
                return
            }
            
            if pin.count == maxDigits {
                isDisabled = true
                
                handler(pin) { isSuccess in
                    if isSuccess {
                        print("pin matched, go to next page, no action to perfrom here")
                    } else {
                        pin = ""
                        isDisabled = false
                        print("this has to called after showing toast why is the failure")
                    }
                }
            }
            
            // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
            // max digits, we remove the additional characters and make a recursive call.
            if pin.count > maxDigits {
                pin = String(pin.prefix(maxDigits))
                submitPin()
            }
        }
    
    private func getImageName(at index: Int) -> String {
           if index >= self.pin.count {
               return "circle"
           }
           
           if self.showPin {
               return self.pin.digits[index].numberString + ".circle"
           }
           
           return "circle.fill"
       }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

struct BoxNumberField_Previews: PreviewProvider {
    static var previews: some View {
        BoxNumberField(handler: {_,_ in })
    }
}
