//
//  TripModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 27.09.2022.
//

import Foundation
import CoreLocation

struct Trip {
    var coordinates: [CLLocationCoordinate2D]
    
    static func getMockedTrip() -> Trip {
        return Trip(coordinates: [
            CLLocationCoordinate2D(latitude: 46.77049, longitude: 23.592423),
            CLLocationCoordinate2D(latitude: 46.77149, longitude: 23.591623),
            CLLocationCoordinate2D(latitude: 46.77249, longitude: 23.591423),
            CLLocationCoordinate2D(latitude: 46.77349, longitude: 23.511423),
            CLLocationCoordinate2D(latitude: 46.77449, longitude: 23.591423),
            CLLocationCoordinate2D(latitude: 46.77549, longitude: 23.591423),
            CLLocationCoordinate2D(latitude: 46.77649, longitude: 23.5914),
            CLLocationCoordinate2D(latitude: 46.77749, longitude: 23.59123),
            CLLocationCoordinate2D(latitude: 46.77849, longitude: 23.59123),
            CLLocationCoordinate2D(latitude: 46.77949, longitude: 23.891423)
        ])
    }
}
