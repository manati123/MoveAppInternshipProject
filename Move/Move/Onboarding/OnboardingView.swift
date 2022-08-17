//
//  OnboardingView2.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import SwiftUI


struct OnboardingView: View {
    
    static let id = String(describing: Self.self)
    var onboardingData: OnboardingModel
    let onFinished: () -> Void
    let onNext: () -> Void
        
    var body: some View {
        VStack {
            imageContainer
            detailContainer
        }
    }
    
    var detailContainer: some View {
            VStack {
                HStack {
                    Text(onboardingData.title)
                        .font(Font.baiJamjuree.heading1)
                        .foregroundColor(Color("PrimaryBlue"))
                        
                        
                    Spacer()
                    Button {
                        onFinished()
                    } label: {
                        Text("Skip")
                            .font(Font.baiJamjuree.body2)
                            .opacity(0.4)
                    }
                }
                .padding(.bottom, 12)
                
                Text(onboardingData.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("PrimaryPurple"))
                    .font(Font.baiJamjuree.smallText)
                    .lineSpacing(4)
                Spacer()
                HStack {
                    StepIndicatorView(numberOfSteps: 5, currentStepIndex: onboardingData.step)
                    Spacer()
                    Button(action: {
                        onNext()
                    }) {
                        HStack {
                            Text(onboardingData.buttonText)
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
                Image(onboardingData.image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    
            )
        }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
//        OnboardingView(onFinished: {}, onNext: {})
        Text("F")
    }
}
