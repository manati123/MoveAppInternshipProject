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
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: OnboardingView(onboardingData: OnboardingData.safety(), onFinished: {}, onNext: {onboardingSlide = .scan})
                    .navigationBarHidden(true)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.default),
                               tag: OnboardingSlide.safety, selection: $onboardingSlide) {
                    EmptyView()
                }
                NavigationLink(destination: OnboardingView(onboardingData: OnboardingData.scan(), onFinished: {}, onNext: {onboardingSlide = .ride})
                    .navigationBarHidden(true)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.default),
                               tag: OnboardingSlide.scan, selection: $onboardingSlide) {
                    EmptyView()
                }
                NavigationLink(destination: OnboardingView(onboardingData: OnboardingData.ride(), onFinished: {}, onNext: {onboardingSlide = .parking})
                    .navigationBarHidden(true)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.default),
                               tag: OnboardingSlide.ride, selection: $onboardingSlide) {
                    EmptyView()
                }
                NavigationLink(destination: OnboardingView(onboardingData: OnboardingData.parking(), onFinished: {}, onNext: {onboardingSlide = .rules})
                    .navigationBarHidden(true)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.default),
                               tag: OnboardingSlide.parking, selection: $onboardingSlide) {
                    EmptyView()
                }
                NavigationLink(destination: OnboardingView(onboardingData: OnboardingData.rules(), onFinished: {}, onNext: {onboardingSlide = .safety})
                    .navigationBarHidden(true)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    .animation(.default),
                               tag: OnboardingSlide.rules, selection: $onboardingSlide) {
                    EmptyView()
                }
            }
        }
    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCoordinatorView()
    }
}
