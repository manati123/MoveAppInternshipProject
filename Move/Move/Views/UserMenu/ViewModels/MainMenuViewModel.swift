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
        
        
        func getRides(completionHandler: @escaping (Int)->()) {
//            var val: Int = -1
            scooterAPI.getAllRides { result in
                switch result {
                case .success(let numberOfRides):
                    completionHandler(numberOfRides)
//                    val = numberOfRides
//                    self.numberOfRides = numberOfRides
                case .failure:
                    print("Error")
                }
            }
            
        }
        
        
    }
}
