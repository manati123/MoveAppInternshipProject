//
//  OnboardingViewModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.08.2022.
//

import Foundation

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
    var buttonText: String = "Next"
}

class OnboardingViewModel: ObservableObject {
    let steps: [OnboardingModel] = [
        OnboardingModel(image: "SafetyImage", title: "Safety", text: "Please wear a helmet and protect yourself while riding.", buttonText: "Next"),
        OnboardingModel(image: "Scan", title: "Scan", text: "Scan the QR code or NFC sticker on top of the scooter to unlock and ride.", buttonText: "Next"),
        OnboardingModel(image: "Ride", title: "Ride", text: "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate.", buttonText: "Next"),
        OnboardingModel(image: "Parking", title: "Parking", text: "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps.", buttonText: "Next"),
        OnboardingModel(image: "Rules", title: "Rules", text: "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws.", buttonText: "Get Started")
        ]
    
    @Published var currentSlideIndex: Int = 0
    
    var currentSLide: OnboardingModel {
        steps[currentSlideIndex]
    }
    
    func nextSlide(onFinished: () -> Void) {
        if currentSlideIndex < steps.count - 1 {
            currentSlideIndex += 1
        }
        else {
            onFinished()
        }
    }
    
    
}
