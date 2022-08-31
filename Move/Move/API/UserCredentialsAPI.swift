//
//  UserCredentialsAPI.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import Alamofire
import SwiftUI
struct User: Hashable, Codable {
    var name: String
    var password: String
    var email: String
    var _id: String?
    var __v: Int?
    var updatedAt: String?
    var createdAt: String?
}

struct LoggedUser: Codable {
    var user: User
    var token: String
}

struct ServerError: Decodable {
    var message: String
}



typealias Result<Success> = Swift.Result<Success, Error>

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
                    completionHandler(.failure(error))
            }
        }
    }
  
    
    
    func registerUser(user: User, completionHandler:@escaping (Result<LoggedUser>) -> ()) {
        let parameters = [
            "name": user.name,
            "email": user.email,
            "password": user.password
        ]
        
        AF.request("\(baseUrl)/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
               switch response.result {
                   case .success(let data):
                       do {
                           let decodedUser = try JSONDecoder().decode(LoggedUser.self, from: data)
                           completionHandler(.success(decodedUser))
                       } catch {
                           completionHandler(.failure(error))
                           return
                       }
                   case .failure(let error):
//                   print(try! JSONDecoder().decode(ServerError.self, from: response.data!))
//                   error.failureReason = try! JSONDecoder().decode(ServerError.self, from: response.data!)
                   
                   completionHandler(.failure(error))
//                   throw error
               }
           }
        
    }
}
