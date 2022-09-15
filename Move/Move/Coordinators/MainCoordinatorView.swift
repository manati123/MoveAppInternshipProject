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
                    switch userViewModel.user.drivinglicense != "" {
                    case true:
                        self.selection = OnboardingEnum.map
                    case false:
                        self.selection = OnboardingEnum.license
                    }
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
                    AuthenticationAPI().logOut(loggedUser: self.userViewModel.sessionUser, completionHandler: {_ in })
                } onFinished: {
                    self.selection = OnboardingEnum.none
                }.preferredColorScheme(.light).navigationBarHidden(true), tag: .map, selection: $selection) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
            }.navigationBarHidden(true)
                .onAppear {
                    
                }
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
                        print(user.drivinglicense)
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
//                if self.userDefaultsService.isOnboarded()  {
//
//                    let token = userDefaultsService.loadTokenFromDefaults()
//                    print(token)
//                    AuthenticationAPI().getUser(token: token) { result in
//                        print(result)
//                    }
//                    if let decodedUser = try? self.userDefaultsService.loadUserFromDefaults() {
//                        if decodedUser.user.validated ?? false {
//                            print("MAP")
//                            self.selection = .map
//                        }
//                        else {
//                            self.selection = .license
//                        }
//                    } else {
//                        self.selection = .authentication
//                    }
//                }
//                else {
//                    self.selection = .onboarding
//                }
            }
        }.navigationBarHidden(true)
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
