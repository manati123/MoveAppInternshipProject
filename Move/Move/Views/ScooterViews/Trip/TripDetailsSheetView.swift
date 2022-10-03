//
//  TripDetailsSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI
import CoreLocation


struct TripDetailsSheetView: View {
    @StateObject var viewModel: ViewModel
    let endRide:() -> Void
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    init(scooter: Scooter, mapCoordinatorViewModel: MapCoordinatorViewModel ,endRide:@escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter, lockStatus: false))
        self.endRide = endRide
        self.mapCoordinatorViewModel = mapCoordinatorViewModel
        
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Trip Details")
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
                .padding(.vertical, 20)
            BatteryView(battery: self.viewModel.scooter.battery ?? 100)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
                .padding(.bottom, 24)
            TripTimeAndDistanceView(mapCoordinatorViewModel: self.mapCoordinatorViewModel, timeIsRunning: self.$viewModel.timerIsRunning)
            HStack(spacing: 20) {
                Button {
                    self.viewModel.lockStatus.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(self.viewModel.lockStatus ? ImagesEnum.unlock.rawValue : ImagesEnum.lock.rawValue)
                        Text(self.viewModel.lockStatus ? "Unlock" : "Lock")
                            .frame(maxWidth: .infinity)
                            
                    }
                    .padding(.horizontal, 28)
                }
                .buttonStyle(.transparentButton)
                Button {
                    print("Ending ride")
                    endRide()
//                    self.viewModel.endRide(idRide: <#T##String#>, userLocation: <#T##CLLocationCoordinate2D#>, userToken: <#T##String#>, onSuccess: <#T##() -> Void#>)
                    self.viewModel.timerIsRunning = false
                } label: {
                        Text("End ride")
                        .padding(.horizontal, 28)
                        .padding(.vertical, 3)
                }
                .buttonStyle(.filledButton)
            }.padding(.horizontal, 24)
                .padding(.bottom, 36)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

extension TripDetailsSheetView {
    class ViewModel: ObservableObject {
        @Published var scooter: Scooter
        @Published var lockStatus: Bool
        @Published var timerIsRunning = true {
            didSet {
                print("VALUE OF timerIsRunning = \(timerIsRunning)")
                self.objectWillChange.send()
            }
        }
        init(scooter: Scooter, lockStatus: Bool) {
            self.scooter = scooter
            self.lockStatus = lockStatus
        }
        
        func lockScooter() {
            self.lockStatus = true
            ScooterAPI().lockScooter(scooterNumber: scooter.number ?? 0000, token: UserDefaultsService().loadTokenFromDefaults())
        }
        
        func unlockScooter() {
            self.lockStatus = false
            ScooterAPI().unlockScooter(scooterNumber: scooter.number ?? 0000, token: UserDefaultsService().loadTokenFromDefaults())
        }
    }
}
