//
//  SplashView.swift
//  Move
//
//  Created by Silviu Preoteasa on 08.08.2022.
//

import SwiftUI

struct SplashView: View {
    let onFinished: () -> Void
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack{
                    Spacer()
                    HStack{
                        
                        ZStack{
                            Image("CenterGroup")
                            Image("ScooterPNG")
                                .offset(x: -180)
                            Image("MOVE")
                        }
                        .offset(x: -90, y: 0)
                    }
                    Spacer()
                }
            }
//            .padding(/*@START_MENU_TOKEN@*/140.0/*@END_MENU_TOKEN@*/)
            .background(Color("SplashBackground"))
        }
        .onAppear() {
            onFinished()
//            for family in UIFont.familyNames {
//                    print(family)
//
//                    for names in UIFont.fontNames(forFamilyName: family){
//                    print("== \(names)")
//                    }
//               }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SplashView()
//            SplashView()
//        }
//    }
//}
