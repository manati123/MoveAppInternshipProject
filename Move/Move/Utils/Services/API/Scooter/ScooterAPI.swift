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
    var internalId: String?
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
    
    
    func getScooterByNumber(scooterNumber: Int, completionHandler:@escaping (Result<Scooter>) -> Void) {
        AF.request("\(baseUrl)/\(scooterNumber)", method: .get)
            .validate(statusCode: 200..<299)
            .responseDecodable(of: Scooter.self) { response in
                switch response.result {
                case .success(let scooter):
                    completionHandler(.success(scooter))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    func lockScooter(scooterNumber: Int, token: String) {
        let parameters = [
            "scooterNumber": scooterNumber
        ]
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("\(baseUrl)/lock", method: .patch, parameters: parameters, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
    
    func unlockScooter(scooterNumber: Int, token: String) {
        let parameters = [
            "scooterNumber": scooterNumber
        ]
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("\(baseUrl)/unlock", method: .patch, parameters: parameters, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
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
