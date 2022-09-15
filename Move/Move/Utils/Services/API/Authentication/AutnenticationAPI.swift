//
//  UserCredentialsAPI.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import Alamofire
import SwiftUI


//extension Result {
//    func map<NewSuccess>(_ mapping: (Success) throws -> NewSuccess) -> Result<NewSuccess> {
//        //Cine face body-u asta e tare si are 10 lei
//    }
//}

class AuthenticationAPI {
    private let baseUrl = "https://scooter-app.herokuapp.com"
    static let shareInstance = AuthenticationAPI()
    
    func loginUser(user: User, completionHandler: @escaping (Result<LoggedUser>) -> ()) {
        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        print(parameters)
        AF.request("\(baseUrl)/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedUser = try JSONDecoder().decode(LoggedUser.self, from: data)
                    print(decodedUser)
                    completionHandler(.success(decodedUser))
                } catch(let error) {
                    print(error)
                    completionHandler(.failure(error))
                }
            case .failure:
                do {
                    let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                    completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                } catch(let error) {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    
    
    
    
    func registerUser(user: User, completionHandler:@escaping (Result<UserDTO>) -> ()) {
        let parameters = [
            "name": user.name,
            "password": user.password,
            "email": user.email
        ]
        print(parameters)
        AF.request("\(baseUrl)/auth/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
            switch response.result {
            case .success(let data):
                //                   print("\n data: \(try! JSONDecoder().decode(User.self, from: data)) \n")
                do {
                    let decodedUser = try JSONDecoder().decode(UserDTO.self, from: data)
                    print(decodedUser)
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
    
    func logOut(token: String, completionHandler: @escaping (Result<LoggedUser>) -> ()) {
        let header : HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("\(baseUrl)/auth/logout", method: .delete, parameters: nil, headers: header).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success:
                print("Success")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getUser(token: String, completionHandler: @escaping (Result<User>) -> ()) {
        let header: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request("\(baseUrl)/user/currUser", method: .get, parameters: nil, headers: header)
            .validate(statusCode: 200 ..< 299)
            .responseData{ response in
                switch response.result {
                case .success(let user):
                    do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: user)
                    completionHandler(.success(decodedUser))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case .failure:
                    do {
                        let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                        completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                    } catch(let error) {
                        completionHandler(.failure(error))
                    }
                }
            }
    }
}

