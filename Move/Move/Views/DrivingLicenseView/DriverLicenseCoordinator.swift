//
//  DriverLicenseCoordinator.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import Foundation
import SwiftUI
enum DriverState: String {
    case info = "Information"
    case waiting = "Waiting"
    case validated = "Validated"
}

struct DriverLicenseCoordinatorView: View {
    @State private var driverState: DriverState? = .info
    var userDefaults: UserDefaultsService
    let logOut:() -> Void
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: LicenseInformationView(onLogOut: logOut, onFinished: {
                    driverState = .waiting
                }, onUploadDone: {
                    driverState = .validated
                }, onUploadFailed: {
                    driverState = .info
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .info, selection: $driverState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: WaitingForValidationView(onFinished: {
                    driverState = .validated
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .waiting, selection: $driverState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                
                NavigationLink(destination: ValidatedView(onFinished: {
                    onFinished()
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .validated, selection: $driverState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
            }
            .navigationBarHidden(true)
        }
    }
}
