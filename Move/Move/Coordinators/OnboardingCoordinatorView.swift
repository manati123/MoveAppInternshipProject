//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI
import NavigationStack
struct OnboardingCoordinatorView: View {
    @StateObject var viewModel = OnboardingViewModel()
    let onFinished:() -> Void
    var body: some View {
        ZStack {
            Color.clear
            currentSlideView()
                .id(viewModel.currentSlideIndex)
                .transition(.opacity)
        }
        .animation(.default, value: viewModel.currentSlideIndex)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .navigationBarHidden(true)
    }
    
    func currentSlideView() -> some View {
        return OnboardingView(onboardingData: viewModel.currentSLide, onFinished: {
            self.onFinished()
        }, onNext: {
            if viewModel.currentSlideIndex == 4 {
                viewModel.nextSlide {
                    UserDefaults.standard.set(true, forKey: "DoneOnboarding")
                    onFinished()
                }
            } else {
                viewModel.nextSlide(onFinished: {})
            }
        })
    }
    
    
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView(onFinished: {})
    }
}
