//
//  MainMenuViewModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 15.09.2022.
//

import Foundation
import SwiftUI


extension MainMenuView {
    class ViewModel: ObservableObject {
        var scooterAPI: ScooterAPI = .init()
        @Published var numberOfRides: Int = 0
        
    }
}
