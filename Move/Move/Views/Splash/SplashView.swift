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
        
        //
        ZStack {
            Color.primaryPurple
                .ignoresSafeArea()
            Image(ImagesEnum.centerGroup.rawValue)
            Image(ImagesEnum.scooterSplashImage.rawValue)
                .offset(x: -116)
            Image(ImagesEnum.grayMoveLogo.rawValue)
        }
        .onAppear() {
            onFinished()
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
