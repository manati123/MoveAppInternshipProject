//
//  MapContainerScreenViewModel.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 10.09.2022.
//

import Foundation
import CoreLocation
import SwiftUI
import Alamofire

extension MapContainerScreen {
    class ViewModel: ObservableObject {
        @Published var refreshScooterTimer = Timer()
        @Published var updateRide = Timer()
        @Published var refreshUserLocationTimer = Timer()
        @Published var selectedScooter: ScooterAnnotation?
        @Published var scooters: [Scooter] = .init()
        @Published var mapViewModel: ScooterMapViewModel = .init()
        @Published var userLocation: String = ""
        @Published var showUnlockingSheet = false
        @Published var currentRideId = ""
        @Published var rideRunning = false
        var scooterAPI: ScooterAPI = .init()
        var rideAPI: RideAPI = .init()
        init () {
            
            
            if let rideId = UserDefaults.standard.string(forKey: UserDefaultsEnum.activeRide.rawValue) {
                self.currentRideId = rideId
            }
            
            self.convertUserCoordinatesToAddress()
            mapViewModel.onSelectedScooter = { scooter in
                self.selectedScooter = scooter
            }
            
            mapViewModel.onDeselectedScooter = {
                self.selectedScooter = nil
            }
            
            self.refreshScooterTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
                self.mapViewModel.refreshScooterList()
            })
            
            self.refreshUserLocationTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { _ in
                self.convertUserCoordinatesToAddress()
            })
            
            
        }
        
        func updateTimerMethod() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if self.rideRunning {
                    self.updateRide(token: UserDefaultsService().loadTokenFromDefaults(), currentLocation: self.mapViewModel.locationManager?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), scooterId: self.selectedScooter?.scooterData._id ?? "") { result in
                        print(result)
                    }
                    self.updateTimerMethod()
                }
            }
        }
        
        //TODO: MKMAPDidChangeRegion
        func endRide() {
            RideAPI().endRide(idRide: self.currentRideId , userLocation: self.mapViewModel.locationManager?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), userToken: UserDefaultsService().loadTokenFromDefaults()) { result in
                switch result {
                case .success(let data):
                    UserDefaults.standard.removeObject(forKey: UserDefaultsEnum.activeRide.rawValue)
                    self.rideRunning = true
                    print(data)
                case .failure(let error):
                    ErrorService().showError(message: ErrorService().getServerErrorMessage(error))
                }
            }
        }
        
        func updateRide(token: String, currentLocation: CLLocationCoordinate2D, scooterId: String, completionHandler: @escaping (Result<Ride>) -> ()) {
            rideAPI.updateRide(token: token, currentLocation: currentLocation, scooterId: scooterId) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    ErrorService().showError(message: ErrorService().getServerErrorMessage(error))
                }
            }
        }
        
        func startRide(scooter: Scooter, completion:@escaping (Result<Ride>) -> Void) {
            print("\n START RIDE \n")
            print(scooter)
            if let location = self.mapViewModel.locationManager?.location {
                print(location)
                self.rideAPI.startRide(scooter: scooter, userLocation: location.coordinate, userToken: UserDefaultsService()
                    .loadTokenFromDefaults()) { result in
                        switch result {
                        case .success(let data):
                            if let id = data._id {
                                self.currentRideId = id
                                UserDefaults.standard.set(id, forKey: UserDefaultsEnum.activeRide.rawValue)
                                self.rideRunning = true
                                self.updateTimerMethod()
                            }
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
        
        
        
        //        func followingUser() -> Bool {
        //            return self.mapViewModel.locationIsDisabled()
        ////            return self.mapViewModel.mapView.userTrackingMode == .followWithHeading
        //        }
        
        func goToScooterLocation() {
            // Open and show coordinate
            let url = "maps://?saddr=&daddr=\( selectedScooter!.coordinate.latitude),\(selectedScooter!.coordinate.longitude)"
            UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
        }
        
        func convertUserCoordinatesToAddress() {
            CLGeocoder().reverseGeocodeLocation(self.mapViewModel.locationManager?.location ?? CLLocation(latitude: 0, longitude: 0)) { placemarks, error in
                if error == nil {
                    self.userLocation = placemarks?.first?.name ?? "Address Unavailable"
                }
                else {
                    print(error as Any)
                }
            }
        }
        
        func loadScooters() {
            
            self.scooterAPI.getScootersByLocation(userLocation: self.mapViewModel.locationManager?.location?.coordinate ?? CLLocationCoordinate2D(latitude: 46.770439, longitude: 23.591423)) { result in
                switch result {
                case .success(let result):
                    self.scooters = result
                    self.convertScootersToAnnotations()
                case .failure(let error):
                    print(error)
                    
                }
                
            }
        }
        
        func convertCoordinatesToAddress(scooter: Scooter, completionHandler: @escaping (String) -> Void) {
            let location = CLLocation(latitude: scooter.location!.coordinates![1], longitude: scooter.location!.coordinates![0])
            var address = ""
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if error == nil {
                    address = placemarks?.first?.name ?? "No address"
                    completionHandler(address)
                }
                else {
                    print(error as Any)
                }
            }
        }
        
        func convertScootersToAnnotations() {
            for scooter in scooters {
                let scooterAnnotation = ScooterAnnotation(coordinate: CLLocationCoordinate2D(latitude: (scooter.location?.coordinates?[1])!, longitude: (scooter.location?.coordinates?[0])!), scooterData: scooter)
                self.mapViewModel.scooters.append(scooterAnnotation)
            }
        }
        
    }
}
