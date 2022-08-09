//
//  SliderView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI

struct SliderView: View {
    @State var currentPage = 0
    var body: some View {
        HStack{
            ForEach(0..<5) {
                if $0 == currentPage {
                    Text("_")
                }
                else {
                    Text(".")
                }
            }
            Spacer()
            Button("Next ->") {
                withAnimation(.easeOut(duration: 0.01)){
                    
                currentPage += 1
                }
            }
        }.padding()
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
