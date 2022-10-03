//
//  RideAPI.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 21.09.2022.
//

import Foundation
import CoreLocation
import Alamofire
class RideAPI {
    private let baseUrl = "https://scooter-app.herokuapp.com"
    static let shareInstance = RideAPI()
    
    func startRide(scooter: Scooter, userLocation: CLLocationCoordinate2D, userToken: String, completionHandler:@escaping (Result<Ride>)-> Void) {
        
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        
        let parameters = [
            "idScooter": scooter._id! as String,
            "latUser": userLocation.latitude,
            "scooterNumber": scooter.number! as Int,
            "longUser": userLocation.longitude
        ] as [String : Any]
        print("\n \n \n PARAMETERS FOR START RIDE REQUEST: \(parameters)")
        print("HEADER FOR START RIDE REQUEST: \(header)\n \n \n ")
        AF.request("\(baseUrl)/ride/start", method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedRide = try JSONDecoder().decode(Ride.self, from: response.data!)
                        completionHandler(.success(decodedRide))
                    } catch {
                        print(error)
                    }
                case .failure:
                        let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
        
    }
    
    func checkIfUserIsInRide(userToken: String, completionHandler:@escaping (Result<Any>) -> Void) {
        
    }
    
    func endRide(idRide: String, userLocation: CLLocationCoordinate2D, userToken: String , completionHandler:@escaping (Result<Ride>) -> Void) {
        
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        
        let parameters = [
            "idRide": idRide,
            "latitude": userLocation.latitude,
            "longitude": userLocation.longitude
        ] as [String : Any]
        
        AF.request("\(baseUrl)/ride/end", method: .patch, parameters: parameters, headers: header)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let decodedRide = try JSONDecoder().decode(Ride.self, from: response.data!)
                        completionHandler(.success(decodedRide))
                    } catch {
                        print(error)
                    }
                case .failure:
                    let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
    }
    
    
    func viewUserRide(token: String, completionHandler:@escaping (Result<LiveRide>) -> ()) {
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request("\(baseUrl)/ride/details", method: .get, parameters: nil, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let ride = try JSONDecoder().decode(LiveRide.self, from: response.data!)
                        completionHandler(.success(ride))
                    } catch {
                        print(error)
                    }
                case .failure:
                let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
    }
    
    func updateRide(token: String, currentLocation: CLLocationCoordinate2D, scooterId: String, completionHandler: @escaping (Result<Ride>) -> ()) {
        let parameters = [
            "idScooter" : scooterId,
            "longitude": currentLocation.longitude,
            "latitude": currentLocation.latitude
        ] as [String: Any]
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("\(baseUrl)/ride/update", method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let ride = try JSONDecoder().decode(Ride.self, from: response.data!)
                        completionHandler(.success(ride))
                    } catch {
                        print(error)
                    }
                case.failure:
                    let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
        
    }
    
    func getCurrentTripDetails(token: String, completionHandler:@escaping (Result<LiveRide>) -> Void) {
        let headers: HTTPHeaders = ["Authorization" : "Bearer: \(token)"]
        
        AF.request("\(baseUrl)/ride/details", method: .get, parameters: nil, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                
                switch response.result {
                case .success:
                    do {
                        let ride = try JSONDecoder().decode(LiveRide.self, from: response.data!)
                        completionHandler(.success(ride))
                    } catch {
                        print(error)
                    }
                case .failure:
                    let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
    }
    
    
    
}


