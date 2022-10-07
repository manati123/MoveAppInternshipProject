//
//  LicenseViewModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import Foundation
import UIKit
import SwiftUI

class LicenseViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var imageViewModel = ImagePickerViewModel()
    @Published var showImagePicker = false
    @Published var imagePickerSheetDetents: SheetDetents = .none
    @Published var inputImage: UIImage?
    @Published var image: Image?
    
    
    func sendImageForUpload(onUploadDone: @escaping () -> Void, onFailure: @escaping () -> Void) {
        DriverLicenseAPI().uploadForValidation(image: imageViewModel.image) { result in
            switch result {
            case .success:
                onUploadDone()
            case .failure(let error):
                onFailure()
                ErrorService().showError(message: error.localizedDescription)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func logOut(onLogOut: () -> Void) {
        let token = UserDefaultsService().loadTokenFromDefaults()
        AuthenticationAPI().logOut(token: token) { result in
            print(result)
            switch result {
            case .success:
                print("success")
            case .failure:
                ErrorService().showError(message: "User could not be logged out!")
            }
        }
        UserDefaults.standard.removeObject(forKey: UserDefaultsEnum.loggedUser.rawValue)
        onLogOut()
        
    }
}
