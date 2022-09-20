//
//  ScooterCardViewModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 12.09.2022.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

extension ScooterCardView {
    class ViewModel: ObservableObject {
        @Published var scooterData: Scooter
        @Published var address: String = ""
        
        init(scooter: Scooter) {
            self.scooterData = scooter
        }
        
        func convertLocation() {
            let location = CLLocation(latitude: scooterData.location?.coordinates?[1] ?? 0, longitude: scooterData.location?.coordinates?[0] ?? 0)
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if error == nil {
                    self.address = placemarks?.first?.name ?? "Address Unavailable"
                    self.objectWillChange.send()
                }
                else {
                    print(error as Any)
                }
            }
        }
    }
}
