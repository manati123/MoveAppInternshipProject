//
//  OnboardingView2.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI


struct OnboardingView: View {
    
    static let id = String(describing: Self.self)
    @StateObject var viewModel = OnboardingViewModel()
    let onFinished: () -> Void
        
    var body: some View {
        VStack {
            imageContainer
            detailContainer
        }.animation(.easeOut, value: viewModel.currentSlideIndex)
    }
    
    var detailContainer: some View {
            VStack {
                HStack {
                    Text(viewModel.currentSLide.title)
                        .font(.custom("BaiJamjuree-BoldItalic", size: 32))
                        .foregroundColor(Color("PrimaryBlue"))
                        
                        
                    Spacer()
                    Button {
                        onFinished()
                    } label: {
                        Text("Skip")
                            .font(.custom("BaiJamjuree-Regular", size: 14))
                            .opacity(0.4)
                    }
                }
                .padding(.bottom, 12)
                
                Text(viewModel.currentSLide.text)
//                    .descriptionStyle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("PrimaryPurple"))
                    .font(.custom("BaiJamjuree-Semibold", size: 16))
                Spacer()
                HStack {
                    StepIndicatorView(numberOfSteps: viewModel.steps.count, currentStepIndex: viewModel.currentSlideIndex)
                    Spacer()
                    Button(action: {
                        viewModel.nextSlide(onFinished: onFinished)
                    }) {
                        HStack {
                            Text(viewModel.currentSLide.buttonText)
                            Image(systemName: "arrow.forward")
                        }.frame(minWidth: 0)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .background(Color("NextButtonColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 40, trailing: 24))
            .background(.white)
            
        }
        
        var imageContainer: some View {
            Color.white.overlay (
                Image(viewModel.currentSLide.image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    
            )
        }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onFinished: {})
    }
}
