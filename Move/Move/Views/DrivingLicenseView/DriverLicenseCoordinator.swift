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
    let onFinished:() -> Void
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: LicenseInformationView(onFinished: {
                    driverState = .waiting
                }).navigationBarHidden(true).transition(.slide.animation(.default)), tag: .info, selection: $driverState) {
                    EmptyView()
                }.transition(.slide.animation(.default))
                    
            }
            .navigationBarHidden(true)
        }
    }
}
