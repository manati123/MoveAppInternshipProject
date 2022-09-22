//
//  ScooterApi.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.09.2022.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftUI
struct Location: Codable {
    var type: String?
    var coordinates: [Double]?
}

struct Scooter: Codable {
    var address: String?
    var location: Location?
    var _id: String?
    var number: Int?
    var battery: Int?
    var lockedStatus: Bool?
    var bookStatus: String?
    var createdAt: String?
    var updatedAt: String?
    var __v: Int?
}

struct Ride {
    var rideId: Int
    var locationsCoordinates: [CLLocation]
}

class ScooterAPI {
    private let baseUrl = "https://scooter-app.herokuapp.com/scooter"
    
    func getAllRides(completionHandler: @escaping(Result<Int>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completionHandler(.success(12))
        }
    }
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter]>) -> ()) {
        AF.request("\(baseUrl)", method: .get)
            .validate()
            .responseDecodable(of: [Scooter].self) { response in
                do {
                    let decoded = try JSONDecoder().decode([Scooter].self, from: response.data!)
                    completionHandler(.success(decoded))
                } catch {
                    completionHandler(.failure(error))
                }
            }
    }
    
    func getScootersByLocation(userLocation: CLLocationCoordinate2D, completionHandler: @escaping (Result<[Scooter]>) -> ()) {
        let parameters = [
            "latitudine": "\(userLocation.latitude)",
            "longitudine": "\(userLocation.longitude)"
        ]
        
        AF.request("\(baseUrl)", method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: [Scooter].self) { response in
                
                do {
                    if response.data != nil {
                        print(response.data!)
                        let decoded = try JSONDecoder().decode([Scooter].self, from: response.data!)
                        completionHandler(.success(decoded))
                    }
                } catch {
                    completionHandler(.failure(error))
                }
            }
    }
}
