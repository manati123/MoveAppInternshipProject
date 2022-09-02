//
//  MainCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI


struct MainCoordinatorView: View {
    @State private var selection: OnboardingEnum? = .splash
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: getSplashView().transition(.slide.animation(.default)).navigationBarHidden(true).preferredColorScheme(.dark), tag: .splash, selection: $selection) {
                    EmptyView()
                }
                .transition(.slide.animation(.default))
                
                
                NavigationLink(destination: OnboardingCoordinatorView(){
                    if UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue) != nil {
                        self.selection = .license
                    }
                    else {
                        self.selection = .authentication
                    }
                }.navigationBarHidden(true).preferredColorScheme(.dark), tag: .onboarding, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
                
                NavigationLink(destination: SignUpCoordinatorView(){
                    self.selection = .license
                }.preferredColorScheme(.dark).navigationBarHidden(true), tag: .authentication, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
                
                NavigationLink(destination: DriverLicenseCoordinatorView(){
                    self.selection = OnboardingEnum.authentication
                } onFinished: {
                    self.selection = OnboardingEnum.none
                }.preferredColorScheme(.light).navigationBarHidden(true), tag: .license, selection: $selection) {
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
                let isOnboarded = UserDefaults.standard.bool(forKey: UserDefaultsEnum.onboarded.rawValue)
                if isOnboarded  {
                    if UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue) != nil {
                        self.selection = .license
                    } else {
                        self.selection = .authentication
                    }
                }
                else {
                    self.selection = .onboarding
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
