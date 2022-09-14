//
//  UserCredentialsModels.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import Alamofire

struct User: Hashable, Codable  {
    var name: String
    var password: String
    var email: String
    var _id: String?
    var __v: Int?
    var updatedAt: String?
    var createdAt: String?
    var drivinglicense: String?
    var validated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case password = "password"
        case email = "email"
        case _id = "_id"
        case __v = "__v"
        case updatedAt = "updatedAt"
        case createdAt = "createdAt"
        case drivinglicense = "drivinglicense"
        case validated = "validated"
       }
}

struct UserDTO: Hashable, Codable {
    var user: User
}

struct LoggedUser: Codable {
    var user: User
    var token: String
}

struct ServerError: Decodable {
    var message: String
}



typealias Result<Success> = Swift.Result<Success, Error>

typealias UploadResult<Success> = DataResponse<LoggedUser, AFError>
