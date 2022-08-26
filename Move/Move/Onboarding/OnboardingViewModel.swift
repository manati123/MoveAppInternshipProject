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
    var onboardingSlide: OnboardingSlide
    var buttonText: String = "Next"
    var step: Int = 0
}

class OnboardingData {
    
    static func getAll() -> [OnboardingModel] {
        [safety(),scan(),ride(),parking(),rules()]
    }
    
    static func safety() -> OnboardingModel {
        OnboardingModel(image: "Safety", title: "Safety", text: "Please wear a helmet and protect yourself while riding.", onboardingSlide: .safety, buttonText: "Next", step: 0)
    }
    
    static func scan() -> OnboardingModel {
        OnboardingModel(image: "Scan", title: "Scan", text: "Scan the QR code or NFC sticker on top of the scooter to unlock and ride.", onboardingSlide: .scan, buttonText: "Next", step: 1)
    }
    
    static func ride() -> OnboardingModel {
        OnboardingModel(image: "Ride", title: "Ride", text: "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate.", onboardingSlide: .ride, buttonText: "Next", step: 2)
    }
    
    static func parking() -> OnboardingModel {
        OnboardingModel(image: "Parking", title: "Parking", text: "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps.", onboardingSlide: .parking, buttonText: "Next", step: 3)
    }
    
    static func rules() -> OnboardingModel {
        OnboardingModel(image: "Rules", title: "Rules", text: "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws.", onboardingSlide: .rules, buttonText: "Get Started", step: 4)
    }
}

class OnboardingViewModel: ObservableObject {
    let steps: [OnboardingModel] = [
        OnboardingModel(image: "SafetyImage", title: "Safety", text: "Please wear a helmet and protect yourself while riding.", onboardingSlide: .safety, buttonText: "Next"),
        OnboardingModel(image: "Scan", title: "Scan", text: "Scan the QR code or NFC sticker on top of the scooter to unlock and ride.", onboardingSlide: .scan, buttonText: "Next"),
        OnboardingModel(image: "Ride", title: "Ride", text: "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate.", onboardingSlide: .ride, buttonText: "Next"),
        OnboardingModel(image: "Parking", title: "Parking", text: "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps.", onboardingSlide: .parking, buttonText: "Next"),
        OnboardingModel(image: "Rules", title: "Rules", text: "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws.", onboardingSlide: .rules, buttonText: "Get Started")
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
