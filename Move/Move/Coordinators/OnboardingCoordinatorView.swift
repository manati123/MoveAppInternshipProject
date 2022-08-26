//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject var viewModel = OnboardingViewModel()
//    @State private var onboardingSlide: OnboardingSlide? = .safety
//    private let onboardingSlides = OnboardingData.getAll()
    let onFinished:() -> Void
    var body: some View {
        ZStack {
            Color.clear
            currentSlideView()
                .id(viewModel.currentSlideIndex)
                .transition(.opacity)
        }
        .animation(.default, value: viewModel.currentSlideIndex)
    }
    
    func currentSlideView() -> some View {
        return OnboardingView(onboardingData: viewModel.currentSLide, onFinished: {
            self.onFinished()
        }, onNext: {
            if viewModel.currentSlideIndex == 4 {
            viewModel.nextSlide {
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
