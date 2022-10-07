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
    let updateRide:() -> Void
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    init(scooter: Scooter, mapCoordinatorViewModel: MapCoordinatorViewModel ,endRide:@escaping () -> Void, updateRide:@escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter, lockStatus: false))
        self.endRide = endRide
        self.mapCoordinatorViewModel = mapCoordinatorViewModel
        self.updateRide = updateRide
        
        
    }
    
    
    
    func viewRide() {
        if self.viewModel.timerIsRunning {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                self.updateRide()
//                callUpdateRide()
                RideAPI().viewUserRide(token: UserDefaultsService().loadTokenFromDefaults()) { result in
                    switch result {
                    case .success(let ride):
                        
                        self.viewModel.scooter.battery = ride.battery
//                        self.mapCoordinatorViewModel.tripDetails.time =
                        let d = ride.distance! / 1000
                        let time = ((ride.time! % 86400000) % 3600000) / 1000
                        var currentTime = ""
                        let minutes = time / 60
                        let hours = minutes / 60
                        if hours != 0 {
                            currentTime = "00 : \(minutes) min"
                        }
                        else {
                            currentTime = "\(hours) : \(minutes) h"
                        }
                        
                        
                        
                        self.mapCoordinatorViewModel.tripDetails.distance = Double((d * 10) / 10)
                        self.mapCoordinatorViewModel.tripDetails.time = currentTime
                        self.mapCoordinatorViewModel.tripDetails.battery = ride.battery ?? 0
                        print("TRIP DETAILS ---->\(self.mapCoordinatorViewModel.tripDetails)")
                        self.updateRide()
                        self.viewRide()
                    case .failure(let error):
                        print(error)
                        self.viewRide()
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Trip Details")
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
                .padding(.vertical, 20)
            BatteryView(battery: self.mapCoordinatorViewModel.tripDetails.battery)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
                .padding(.bottom, 24)
            TripTimeAndDistanceView(mapCoordinatorViewModel: self.mapCoordinatorViewModel, timeIsRunning: self.$viewModel.timerIsRunning)
            HStack(spacing: 20) {
                Button {
//                    self.viewModel.lockStatus.toggle()
                    if viewModel.lockStatus {
                        self.viewModel.unlockScooter()
                    } else {
                        self.viewModel.lockScooter()
                    }
//                    self.viewModel.timerIsRunning = false
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
            .onAppear {
                self.viewRide()
                print("AFISEZ")
            }
            
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
