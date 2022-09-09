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
    let scooterData: Scooter

    init(coordinate: CLLocationCoordinate2D,scooterData: Scooter) {
        self.coordinate = coordinate
        self.scooterData = scooterData
    }
}
