//
//  FlexibleSheet.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

enum SheetDetents {
    case none
    case quarter
    case third
    case half
    case full
}

struct FlexibleSheet<Content: View>: View {
    
    let content: () -> Content
    var sheetDetents: Binding<SheetDetents>
    
    init(sheetDetents: Binding<SheetDetents>, @ViewBuilder content: @escaping () -> Content) {
        
        self.content = content
        self.sheetDetents = sheetDetents
        
    }
    
    private func calculateOffset() -> CGFloat {
        
        switch sheetDetents.wrappedValue {
        case .none:
            return UIScreen.main.bounds.height
        case .quarter:
            return UIScreen.main.bounds.height - 350
        case .half:
            return UIScreen.main.bounds.height/2
        case .full:
            return 0
        case .third:
            return UIScreen.main.bounds.height * 0.55
        }
        
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring())
            .edgesIgnoringSafeArea(.all)
    }
}
struct FlexibleSheet_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheet(sheetDetents: .constant(.quarter)) {
            VStack {
                Text("Hello World")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        }
    }
}
