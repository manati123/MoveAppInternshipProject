//
//  MainCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct MainCoordinatorView: View {
    @State private var selection: String? = "Splash"
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: getSplashView().transition(.slide.animation(.default)).navigationBarHidden(true), tag: "Splash", selection: $selection) {
                    EmptyView()
                }
                .transition(.slide.animation(.default))
                NavigationLink(destination: OnboardingCoordinatorView(){
                    self.selection = "Authentication"
                }.navigationBarHidden(true), tag: "Onboarding", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                NavigationLink(destination: SignUpCoordinatorView(), tag: "Authentication", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
            }
        }
    }
    
    func getSplashView() -> some View {
        return SplashView() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.selection = "Onboarding"
            }
        }
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
