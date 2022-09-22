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
    
    func startRide(scooter: Scooter, userLocation: CLLocationCoordinate2D, userToken: String, completionHandler:@escaping (Result<Any>)-> Void) {
//        print("jshbfj")
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        
        let parameters = [
            "_id": scooter._id! as String,
            "scooterNumber": scooter.number! as Int,
            "latUser": userLocation.latitude,
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
                    completionHandler(.success(data))
                case .failure(let error):
                    do {
                        let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                        completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                    } catch(let error) {
                        completionHandler(.failure(error))
                    }
//                    completionHandler(.failure(error))
                }
            }
        
    }
    
    
}
