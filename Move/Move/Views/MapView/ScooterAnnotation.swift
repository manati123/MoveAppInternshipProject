//
//  ScooterAnnotation.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import MapKit
import UIKit

class ScooterAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let scooterData: ScooterModel

    init(coordinate: CLLocationCoordinate2D,scooterData: ScooterModel) {
        self.coordinate = coordinate
        self.scooterData = scooterData
    }
    
    static func requestMockData()-> [ScooterAnnotation]{
        return [
//            ScooterAnnotation(title: "Bengalore",
//                               subtitle:"Bengaluru (also called Bangalore) is the capital of India's southern Karnataka state.",
//                               coordinate: .init(latitude: 12.9716, longitude: 77.5946)),
//            ScooterAnnotation(title: "Mumbai",
//                               subtitle:"Mumbai (formerly called Bombay) is a densely populated city on India’s west coast",
//                               coordinate: .init(latitude: 19.0760, longitude: 72.8777)),
            ScooterAnnotation(coordinate: .init(latitude: 44.439663, longitude:  26.096306), scooterData: ScooterModel(id: "#AB23", batteryPercentage: 66, address: "Str. Avram Iancu nr.26 Cladirea 2")),
            ScooterAnnotation(coordinate: .init(latitude: 46.770439, longitude:  23.591423), scooterData: ScooterModel(id: "#AB25", batteryPercentage: 66, address: "Str. Avram Iancu nr.26 Cladirea 2"))
        ]
    }
}
