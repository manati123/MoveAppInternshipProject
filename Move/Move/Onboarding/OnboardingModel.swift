//
//  OnboardingModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 08.08.2022.
//

import Foundation
import SwiftUI

enum OnboardingSlide: Int {
    case safety = 0
    case scan = 1
    case ride = 2
    case parking = 3
    case rules = 4
}

struct OnboardingModel {
    var image: String = "SafetyImage"
    var title: String = "Safety"
    var text: String = "Please wear a helmet and protect yourself while riding"
    var onboardingSlide: OnboardingSlide = .safety
}

class OnboardingViewModel: ObservableObject {
    @Published var onboardingModel = OnboardingModel()
    var slideCounter = 0
    
    
    
    @ViewBuilder
    func getView() -> some View {
        AnyView(
            VStack(alignment: .leading) {
                Image(onboardingModel.image)
                    .resizable()
                    .scaledToFit()
                HStack {
                    Text(onboardingModel.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Button("Skip") { }
                    
                }.padding()
                Text(onboardingModel.text)
                    .padding()
                Spacer()
                HStack {
                    Text("Lmao")
                    Spacer()
                    
                    Button {
                        print("pressed")
                        self.slideCounter += 1
//                        self.onboardingModel.onboardingSlide = OnboardingSlide[self.slideCounter]
                    }
                label: {
                    Text("Next \(Image(systemName: "arrow.right"))")
                        .frame(minWidth: 0)
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth:10)
                        )
                    
                    
                }.background(Color("NextButtonColor"))
                        .cornerRadius(25)
                }.padding()
                
                Spacer()
            }.ignoresSafeArea()
            
            
        )
    }
    
}



