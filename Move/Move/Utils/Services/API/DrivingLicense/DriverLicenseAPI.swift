//
//  DriveLicenseApi.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import Foundation
import Alamofire
import SwiftUI



class DriverLicenseAPI {
    
    static let shareInstance = DriverLicenseAPI()
    
    func uploadForValidation(image: Image, completionHandler: @escaping (Result<User>) -> Void ) {
        let loggedUser = try! JSONDecoder().decode(LoggedUser.self, from: UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue) as! Data)
        
        let header : HTTPHeaders = ["Authorization": "Bearer \(loggedUser.token)"]
        let imageData = image.asUIImage().jpegData(compressionQuality: 0.85)!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "drivinglicense", fileName: "\(loggedUser.token).jpeg", mimeType: "image/jpeg")
        }, to: "https://scooter-app.herokuapp.com/auth/driving-license",
                  method: .put,
                  headers: header)
        .response { response in
            do {
                let decoded = try JSONDecoder().decode(User.self, from: response.data!)
                print(decoded)
                completionHandler(.success(decoded))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        
    }
}

