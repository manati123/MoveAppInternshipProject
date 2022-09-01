//
//  LicenseViewModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import Foundation


class LicenseViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var imageViewModel = ImagePickerViewModel()
    
    func sendImageForUpload() {
        DriverLicenseAPI().uploadForValidation(image: imageViewModel.image) { result in
            print(result)
        }
    }
}
