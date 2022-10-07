//
//  RideAPI.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 21.09.2022.
//

import Foundation
import CoreLocation
import Alamofire

struct RideDTO: Codable {
    var updateRide: Ride?
    
    enum CodingKeys: String, CodingKey {
        case updateRide = "updateRide2"
    }
}

class RideAPI {
    private let baseUrl = "https://scooter-app.herokuapp.com"
    static let shareInstance = RideAPI()
    
    func startRide(scooter: Scooter, userLocation: CLLocationCoordinate2D, userToken: String, completionHandler:@escaping (Result<RideDTO>)-> Void) {
        
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        
        let parameters = [
            "idScooter": scooter._id! as String,
            "longUser": userLocation.longitude,
            "latUser": userLocation.latitude,
            "scooterNumber": scooter.number! as Int
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
                        let decodedRide = try JSONDecoder().decode(RideDTO.self, from: response.data!)
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
    
    func endRide(idRide: String, userLocation: CLLocationCoordinate2D, userToken: String , completionHandler:@escaping (Result<RideDTO>) -> Void) {
        
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        
        let parameters = [
            "idRide": idRide,
            "latitude": userLocation.longitude,
            "longitude": userLocation.latitude
        ] as [String : Any]
        
        AF.request("\(baseUrl)/ride/end", method: .patch, parameters: parameters, headers: header)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let decodedRide = try JSONDecoder().decode(RideDTO.self, from: response.data!)
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
        
        let parameters = ["idRide" : UserDefaults.standard.string(forKey: UserDefaultsEnum.activeRide.rawValue) ?? ""]
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        print(parameters)
        print(headers)
        AF.request("\(baseUrl)/ride/details", method: .patch, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success(let data):
                    do {
                        print(data)
                        let ride = try JSONDecoder().decode(LiveRide.self, from: response.data!)
                        completionHandler(.success(ride))
                    } catch {
                        print(error)
                    }
                case .failure:
                    do {
                        let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                        completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                    }catch {
                        print(error)
                    }
                }
            }
    }
    
    func updateRide(token: String, currentLocation: CLLocationCoordinate2D, scooterId: String, completionHandler: @escaping (Result<RideDTO>) -> ()) {
        let parameters = [
            "idScooter" : scooterId,
            "longitude": currentLocation.longitude,
            "latitude": currentLocation.latitude
        ] as [String: Any]
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request("\(baseUrl)/ride/update", method: .patch, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let ride = try JSONDecoder().decode(RideDTO.self, from: response.data!)
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
    
    func getUserRides(pageSize: Int, pageNumber: Int, token: String, completionHandler:@escaping (Result<[ServerRide]>) -> Void) {
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        let parameters = [
            "pageSize" : pageSize,
            "pageNumber" : pageNumber
        ]
        
        AF.request("\(baseUrl)/ride/history?pageSize=\(pageSize)&pageNumber=\(pageNumber)", method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success:
                    do {
                        let decodedData = try JSONDecoder().decode([ServerRide].self, from: response.data!)
                        completionHandler(.success(decodedData))
                    } catch {
                        print(error)
                    }
                case .failure:
                    let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
                }
            }
        
    }
    
//    func getCurrentTripDetails(token: String, completionHandler:@escaping (Result<LiveRide>) -> Void) {
//        let headers: HTTPHeaders = ["Authorization" : "Bearer: \(token)"]
//
//        AF.request("\(baseUrl)/ride/details", method: .get, parameters: nil, headers: headers)
//            .validate(statusCode: 200..<299)
//            .responseData {
//                response in
//
//                switch response.result {
//                case .success:
//                    do {
//                        let ride = try JSONDecoder().decode(LiveRide.self, from: response.data!)
//                        completionHandler(.success(ride))
//                    } catch {
//                        print(error)
//                    }
//                case .failure:
//                    let decodedMessage = try? JSONDecoder().decode(ServerError.self, from: response.data!)
//                    completionHandler(.failure(MoveError.serverError(decodedMessage?.message ?? "IDK")))
//                }
//            }
//    }
    
//    {
//        "startLocation": {
//            "type": "Point",
//            "coordinates": [
//                46.770439,
//                23.591423
//            ]
//        },
//        "endLLocation": {
//            "type": "Point",
//            "coordinates": []
//        },
//        "_id": "633c170d90182a7d567d9a94",
//        "userId": "633c16d190182a7d567d9a81",
//        "scooterId": "633c15dd90182a7d567d9a6a",
//        "duration": 0,
//        "distance": 3306427,
//        "price": 0,
//        "status": "completed",
//        "startMode": "PIN",
//        "allLocation": [
//            {
//                "type": "Point",
//                "coordinates": [],
//                "_id": "633c170d90182a7d567d9a95"
//            },
//            {
//                "type": "Point",
//                "coordinates": [
//                    46.770439,
//                    23.591423
//                ],
//                "_id": "633c170d90182a7d567d9a98"
//            },
//            {
//                "type": "Point",
//                "coordinates": [
//                    46.770439,
//                    23.591423
//                ],
//                "_id": "633c171b90182a7d567d9aa0"
//            }
//        ],
//        "createdAt": "2022-10-04T11:20:45.469Z",
//        "updatedAt": "2022-10-04T11:21:00.174Z",
//        "__v": 0
//    },
    
    
    
}

struct CoordinateLocation: Codable {
    var type: String
    var coordinates: [Double]
}

struct ServerRide: Codable {
    var startLocation: CoordinateLocation
    var endLLocation: CoordinateLocation
    var duration: Int
    var distance: Int
    var _id: String
}


