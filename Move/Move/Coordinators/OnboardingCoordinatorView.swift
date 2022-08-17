//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State private var onboardingSlide: OnboardingSlide? = .safety
    private let onboardingSlides = OnboardingData.getAll()
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                ForEach(0..<5) {index in
                    if index == 4 {
                        NavigationLink(destination: OnboardingView(onboardingData: onboardingSlides[index], onFinished: onFinished, onNext: onFinished).navigationBarHidden(true)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .animation(.default),
                                       tag: onboardingSlides[index].onboardingSlide, selection: $onboardingSlide) {
                            EmptyView()
                        }
                        
                    } else {
                        NavigationLink(destination: OnboardingView(onboardingData: onboardingSlides[index], onFinished: onFinished, onNext: {onboardingSlide = onboardingSlides[index+1].onboardingSlide})
                            .navigationBarHidden(true)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .animation(.default),
                                       tag: onboardingSlides[index].onboardingSlide, selection: $onboardingSlide) {
                            EmptyView()
                        }
                    }
                }
            }
            
        }
    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView(onFinished: {})
    }
}
