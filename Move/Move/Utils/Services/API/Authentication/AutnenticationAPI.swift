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
        AF.request("\(baseUrl)/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedUser = try JSONDecoder().decode(LoggedUser.self, from: data)
                    print(decodedUser)
                    completionHandler(.success(decodedUser))
                } catch {
                    completionHandler(.failure(MoveError.serverError("Something happend while fetching user...")))
                }
            case .failure(let serverError):
                do {
                    if response.response?.statusCode != 503 {
                        let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                        completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                    }
                    else {
                        completionHandler(.failure(MoveError.serverError("Server is down...")))
                    }
                } catch(let error) {
                    print(error)
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
                do {
                    let decodedUser = try JSONDecoder().decode(UserDTO.self, from: data)
                    print(decodedUser)
                    completionHandler(.success(decodedUser))
                    
                } catch(let error) {
                    print(error)
                }
            case .failure(let serverError):
                do {
                    
                    if response.response?.statusCode == 503{
                        completionHandler(.failure(MoveError.serverError("Server is down...")))
                    } else {
                        let decodedMessage = try JSONDecoder().decode(ServerError.self, from: response.data!)
                        completionHandler(.failure(MoveError.serverError(decodedMessage.message)))
                    }
                } catch(let error) {
//                    completionHandler(.failure(serverError))
                    print(error)
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

