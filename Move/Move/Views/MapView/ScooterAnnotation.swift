//
//  ScooterAnnotation.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import MapKit

class ScooterAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
//    var scooterID: String?
//    var scooterBatteryPercentage: Int
//    var scooterAddress: String

    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    static func requestMockData()-> [ScooterAnnotation]{
        return [
//            ScooterAnnotation(title: "Bengalore",
//                               subtitle:"Bengaluru (also called Bangalore) is the capital of India's southern Karnataka state.",
//                               coordinate: .init(latitude: 12.9716, longitude: 77.5946)),
//            ScooterAnnotation(title: "Mumbai",
//                               subtitle:"Mumbai (formerly called Bombay) is a densely populated city on India’s west coast",
//                               coordinate: .init(latitude: 19.0760, longitude: 72.8777)),
            ScooterAnnotation(title: "Bucuresti",
                              subtitle: "Capitala",
                              coordinate: .init(latitude: 44.439663, longitude:  26.096306)),
            ScooterAnnotation(title: "Cluj",
                              subtitle: "Ardial no",
                              coordinate: .init(latitude: 46.770439, longitude:  23.591423))
        ]
    }
}
