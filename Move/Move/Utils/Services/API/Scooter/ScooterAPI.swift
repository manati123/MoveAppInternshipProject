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
    var internal_id: Int?
    var battery: Int?
    var locked_status: Bool?
    var book_status: String?
    var createdAt: String?
    var updatedAt: String?
    var __v: Int?
}

class ScooterAPI {
    private let baseUrl = "https://scooter-app.herokuapp.com/scooter"
    
    func getAllScooters(completionHandler: @escaping (Result<[Scooter]>) -> ()) {
        AF.request("\(baseUrl)", method: .get)
            .validate()
            .responseDecodable(of: [Scooter].self) { response in
                do {
                    var decoded = try JSONDecoder().decode([Scooter].self, from: response.data!)
                    completionHandler(.success(decoded))
                }catch {
                    completionHandler(.failure(error))
                }
            }
    }    
}
