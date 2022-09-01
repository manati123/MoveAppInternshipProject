//
//  UserCredentialsAPI.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import Alamofire
import SwiftUI
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

struct UserInUser: Hashable, Codable {
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

//extension Result {
//    func map<NewSuccess>(_ mapping: (Success) throws -> NewSuccess) -> Result<NewSuccess> {
//        //Cine face body-u asta e tare si are 10 lei
//    }
//}

class AuthenticationAPI {
    
    
    
    private let baseUrl = "https://scooter-app.herokuapp.com/user"
    static let shareInstance = AuthenticationAPI()
    
    
    
    func loginUser(user: User, completionHandler: @escaping (Result<LoggedUser>) -> ()) {
        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        AF.request("\(baseUrl)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
            switch response.result {
                case .success(let data):
                    do {
                        let decodedUser = try JSONDecoder().decode(LoggedUser.self, from: data)
                        completionHandler(.success(decodedUser))
                    } catch(let error) {
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                do {
                    let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                } catch(let error) {
                    completionHandler(.failure(error))
                }
            }
        }
    }
  
    
    
    func registerUser(user: User, completionHandler:@escaping (Result<UserInUser>) -> ()) {
        let parameters = [
            "name": user.name,
            "password": user.password,
            "email": user.email
        ]
        print("\n PARAMETERS: \(parameters) \n")
        
        AF.request("\(baseUrl)/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
               switch response.result {
                   case .success(let data):
//                   print("\n data: \(try! JSONDecoder().decode(User.self, from: data)) \n")
                       do {
                           let decodedUser = try JSONDecoder().decode(UserInUser.self, from: data)
                           completionHandler(.success(decodedUser))
                           
                       } catch let DecodingError.dataCorrupted(context) {
                           print(context)
                       } catch let DecodingError.keyNotFound(key, context) {
                           print("Key '\(key)' not found:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch let DecodingError.valueNotFound(value, context) {
                           print("Value '\(value)' not found:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch let DecodingError.typeMismatch(type, context)  {
                           print("Type '\(type)' mismatch:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch {
                           print("error: ", error)
                       }
                   case .failure(let error):
                       do {
                           let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                           completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                       } catch(let error) {
                           completionHandler(.failure(error))
                       }
//                   throw error
               }
           }
        
    }
}

