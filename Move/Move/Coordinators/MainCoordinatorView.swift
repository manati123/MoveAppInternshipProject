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
                NavigationLink(destination: getSplashView().transition(.slide.animation(.default)).navigationBarHidden(true).preferredColorScheme(.dark), tag: "Splash", selection: $selection) {
                    EmptyView()
                }
                .transition(.slide.animation(.default))
                
                NavigationLink(destination: OnboardingCoordinatorView(){
                    self.selection = "Authentication"
                }.navigationBarHidden(true).preferredColorScheme(.dark), tag: "Onboarding", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: SignUpCoordinatorView(){
                    self.selection = "License"
                }.preferredColorScheme(.dark), tag: "Authentication", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: DriverLicenseCoordinatorView(){
                    self.selection = ""
                }.preferredColorScheme(.light), tag: "License", selection: $selection) {
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
