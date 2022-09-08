//
//  ScooterCardViewModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 08.09.2022.
//

import Foundation
import SwiftUI
import UIKit

class ScooterCardViewModel: ObservableObject {
    @Published var scooterData: ScooterModel
    
    init(scooterData: ScooterModel) {
        self.scooterData = scooterData
    }
}
