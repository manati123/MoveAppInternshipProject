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
        
        let header: HTTPHeaders = ["Authorization": "Bearer \(userToken)"]
        let parameters = [
            "_id": scooter._id as Any,
            "scooterNumber": scooter.number as Any,
            "latUser": userLocation.latitude,
            "longUser": userLocation.longitude
        ] as [String : Any]
        
        AF.request("\(baseUrl)/ride", method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200..<299)
            .responseData {
                response in
                switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
}
