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
    @Published var slideCounter = 0
    @Published var slides: [OnboardingSlide] = [.safety, .scan, .ride, .parking, .rules]
    @Published var shouldHide = false
    
    func changeInfo() {
        switch self.onboardingModel.onboardingSlide {
        case .safety:
            self.onboardingModel.image = "SafetyImage"
            self.onboardingModel.title = "Safety"
            self.onboardingModel.text = "Please wear a helmet and protect yourself while riding"
        case .scan:
            self.onboardingModel.image = "Scan"
            self.onboardingModel.title = "Scan"
            self.onboardingModel.text = "Scan the QR code or NFC sticker on top of the scooter to unlock and ride."
        case .ride:
            self.onboardingModel.image = "Ride"
            self.onboardingModel.title = "Ride"
            self.onboardingModel.text = "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate."
        case .parking:
            self.onboardingModel.image = "Parking"
            self.onboardingModel.title = "Parking"
            self.onboardingModel.text = "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps."
        case .rules:
            self.onboardingModel.image = "Rules"
            self.onboardingModel.title = "Rules"
            self.onboardingModel.text = "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws."
        }
    }
    
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
                        //                        print("\(self.slideCounter + 1) - \(self.slides.count - 1)")
                        if self.slideCounter + 1 >= self.slides.count - 1 {
                            print("haibas")
                            self.slideCounter += 1
                            self.onboardingModel.onboardingSlide = self.slides[self.slideCounter]
                            self.changeInfo()
                            self.shouldHide = true
                            self.objectWillChange.send()
                        }
                        if self.shouldHide == false{
                            self.slideCounter += 1
                            self.onboardingModel.onboardingSlide = self.slides[self.slideCounter]
                            self.changeInfo()
                            self.objectWillChange.send()
                        }
                        self.objectWillChange.send()
                    }
                label: {
                    Text("Next \(Image(systemName: "arrow.right"))")
                        .opacity(shouldHide ? 0 : 1)
                        .frame(minWidth: 0)
                        .padding()
                        .foregroundColor(.white)
                    
                }
                .background(Color("NextButtonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .opacity(shouldHide ? 0 : 1)
                    
                    
                }.padding()
                
                Spacer()
            }.ignoresSafeArea()
            
            
        )
    }
    
}



