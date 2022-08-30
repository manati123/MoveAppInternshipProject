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
                    if UserDefaults.standard.value(forKey: "LoggedUser") != nil {
                        self.selection = "License"
                    }
                    else {
                        self.selection = "Authentication"
                    }
                }.navigationBarHidden(true).preferredColorScheme(.dark), tag: "Onboarding", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
                
                NavigationLink(destination: SignUpCoordinatorView(){
                        self.selection = "License"
                }.preferredColorScheme(.dark).navigationBarHidden(true), tag: "Authentication", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
                
                NavigationLink(destination: DriverLicenseCoordinatorView(){
                    self.selection = ""
                }.preferredColorScheme(.light).navigationBarHidden(true), tag: "License", selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
            }.navigationBarHidden(true)
        }
    }
    
    func getSplashView() -> some View {
//        if UserDefaults.standard.value(forKey: "DoneOnboarding") == nil {
//            UserDefaults.standard.setValue(false, forUndefinedKey: "DoneOnboarding")
//        }
        return SplashView() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let isOnboarded = UserDefaults.standard.bool(forKey: "DoneOnboarding")
                if isOnboarded  {
                    if UserDefaults.standard.value(forKey: "LoggedUser") != nil {
                        self.selection = "License"
                    } else {
                        self.selection = "Authentication"
                    }
                }
                else {
                    self.selection = "Onboarding"
                }
            }
        }.navigationBarHidden(true)
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
