//
//  UserCredentialsAPI.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import Alamofire
import SwiftUI
struct User: Hashable, Decodable {
    var name: String
    var password: String
    var email: String
    var _id: String?
    var __v: Int?
    var updatedAt: String?
    var createdAt: String?
}

struct LoggedUser: Decodable {
    var user: User
    var token: String
}



//{
//    "user": {
//        "_id": "630c78c291a7989d3fbf6be5",
//        "name": "Duamneajutasameargarequestu",
//        "email": "Silviu807@gmail.com",
//        "password": "$2b$10$m2e.eb1a3ir9u1Nr99y4h.YkHgvmaK7jRtOH1lvHB4HdNb6fAZ5T.",
//        "createdAt": "2022-08-29T08:28:50.079Z",
//        "updatedAt": "2022-08-29T08:28:50.079Z",
//        "__v": 0
//    },
//    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzBjNzhjMjkxYTc5ODlkM2ZiZjZiZTUiLCJpYXQiOjE2NjE3NjE3ODJ9.Jsz7pCudOHf1ZciGGRwsI8QMx18ofiSNWF6TaFROZMs"
//}


class AuthenticationAPI {

    @State var finalUser = LoggedUser(user: User(name: "", password: "", email: ""), token: "")
    static let shareInstance = AuthenticationAPI()
    func loginUser(user: User, completionHandler:@escaping (Error?, LoggedUser?) -> ()) {
//        var requestSuccessfull = true
        var decodedUser = LoggedUser(user: user, token: "")
        let parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        AF.request("https://scooter-app.herokuapp.com/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData {
            response in
                switch response.result {
                    case .success(let data):
                        do {
                            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                print("Error: Cannot convert data to JSON object")
                                return
                            }
                            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                                print("Error: Cannot convert JSON object to Pretty JSON data")
                                return
                            }
                            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                print("Error: Could print JSON in String")
                                return
                            }
                            
                            decodedUser = try JSONDecoder().decode(LoggedUser.self, from: data)
                            completionHandler(nil, decodedUser)
//                            print(decodedUser)
                            
                        } catch {
                            print("Error: Trying to convert JSON data to string")
                            completionHandler(error, nil)
                            return
                        }
                    case .failure(let error):
                        completionHandler(error, nil)
                }
        }
        
        
//        print("_____\(response) _____")
        
    }
    
    func doLogin(user: User) -> LoggedUser {
        self.loginUser(user: user) { error, response in
//            print(response!)
                print("=========================")
                print(response!)
                self.finalUser.token = response!.token
                print(self.finalUser)
                print("=========================")
            
//            self.finalUser = response!
            
        }
//        print(finalUser)
        return self.finalUser
    }
    
    
  
    
    func registerUser(user: User) {
        let parameters = [
            "name": user.name,
            "email": user.email,
            "password": user.password
        ]
        
        AF.request("https://scooter-app.herokuapp.com/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
               switch response.result {
                   case .success(let data):
                       do {
                           guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                               print("Error: Cannot convert data to JSON object")
                               return
                           }
                           guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                               print("Error: Cannot convert JSON object to Pretty JSON data")
                               return
                           }
                           guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                               print("Error: Could print JSON in String")
                               return
                           }
                   
                           print(prettyPrintedJson)
                       } catch {
                           print("Error: Trying to convert JSON data to string")
                           return
                       }
                   case .failure(let error):
                       print(error)
               }
           }
        
    }
}
