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
    
    func uploadForValidation(image: Image, completionHandler: @escaping (UploadResult<LoggedUser>) -> Void ) {
        let loggedUser = try! JSONDecoder().decode(LoggedUser.self, from: UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue) as! Data)
        
        let imageData = image.asUIImage().jpegData(compressionQuality: 0.85)!
        
        let parameters = [
            "email" : loggedUser.user.email
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "baftalalicentza", fileName: "\(loggedUser.token).jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                    } //Optional for extra parameters
        }, to: "https://scooter-app.herokuapp.com/user/login", method: .put)
        
            .responseDecodable(of: LoggedUser.self) { response in
                completionHandler(response)
            }
    }
}

