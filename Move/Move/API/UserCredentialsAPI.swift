//
//  UserCredentialsAPI.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import Alamofire

struct User: Hashable, Encodable {
    var name: String
    var password: String
    var email: String
}


class AuthenticationAPI {
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
