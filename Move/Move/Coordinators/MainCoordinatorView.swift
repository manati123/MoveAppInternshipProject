//
//  MainCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI


struct MainCoordinatorView: View {
    @StateObject private var viewModel: ViewModel = .init()
    @StateObject var userViewModel: UserViewModel = .init(userDefaultsService: UserDefaultsService())
    @State var selection: OnboardingEnum? = .splash
    var userDefaultsService: UserDefaultsService = .init()
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: getSplashView().transition(.slide.animation(.default)).navigationBarHidden(true).preferredColorScheme(.dark), tag: .splash, selection: $selection) {
                    EmptyView()
                }
                .transition(.slide.animation(.default))
                NavigationLink(destination: OnboardingCoordinatorView(userDefaultsService: userDefaultsService){
                    self.selection = .authentication
                }.navigationBarHidden(true).preferredColorScheme(.dark), tag: .onboarding, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                
                NavigationLink(destination: SignUpCoordinatorView(viewModel: userViewModel){
                    setFlowOfApplication()
                }.preferredColorScheme(.dark).navigationBarHidden(true), tag: .authentication, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                
                NavigationLink(destination: DriverLicenseCoordinatorView(userDefaults: userDefaultsService){
                    self.selection = OnboardingEnum.authentication
                } onFinished: {
                    self.selection = OnboardingEnum.map
                }.preferredColorScheme(.light).navigationBarHidden(true), tag: .license, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: MapCoordinatorView(userViewModel: userViewModel){
                    self.selection = OnboardingEnum.authentication
                    AuthenticationAPI().logOut(token: self.userViewModel.sessionUser.token, completionHandler: {_ in })
                } onFinished: {
                    self.selection = OnboardingEnum.menu
                } .preferredColorScheme(.light).navigationBarHidden(true), tag: .map, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                
                NavigationLink(destination: MainMenuCoordinatorView(userViewModel: userViewModel){
                    self.selection = OnboardingEnum.authentication
                    AuthenticationAPI().logOut(token: self.userViewModel.sessionUser.token, completionHandler: {_ in })
                }  onGoBack: {self.selection = .map}.preferredColorScheme(.light).navigationBarHidden(true), tag: .menu, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
//                NavigationLink(destination: UnlockCoordinatorView()
                
                
            }.navigationBarHidden(true)
        }
    }
    
    func setFlowOfApplication() {
        let token = userDefaultsService.loadTokenFromDefaults()
        print(token)
        if token != "" {
            AuthenticationAPI().getUser(token: token) { result in
                switch result {
                case .success(let user):
                    self.userViewModel.sessionUser.user = user
                    self.userViewModel.sessionUser.token = token
                    if user.drivinglicense != nil {
                        print(user.drivinglicense as Any)
                        self.selection = .map
                    } else {
                        self.selection = .license
                    }
                case .failure:
                    self.selection = .authentication
                }
            }
        } else {
            self.selection = .onboarding
        }
        
    }
    
    func getSplashView() -> some View {
        return SplashView() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                setFlowOfApplication()
            }
        }.navigationBarHidden(true)
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
