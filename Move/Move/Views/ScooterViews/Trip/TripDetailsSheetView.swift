//
//  TripDetailsSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

struct TripDetailsSheetView: View {
    @StateObject var viewModel: ViewModel
    
    init(scooter: Scooter) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter, lockStatus: false))
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
            HStack(spacing: 55) {
                
                VStack {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        Text("Travel time")
                    }
                    
                    HStack(alignment: .bottom) {
                        Text("00:12")
                            .font(Font.baiJamjuree.heading1)
                        Text("min")
                            .font(Font.baiJamjuree.heading3)
                            .padding(.bottom, 2)
                    }.foregroundColor(.primaryPurple)
                }
                VStack {
                    HStack(spacing: 4) {
                        Image(systemName: "map")
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        Text("Distance")
                    }
                    HStack(alignment: .bottom) {
                        Text("2.7")
                            .font(Font.baiJamjuree.heading1)
                        Text("km")
                            .font(Font.baiJamjuree.heading3)
                            .padding(.bottom, 2)
                    }.foregroundColor(.primaryPurple)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.neutralGray)
                .font(Font.baiJamjuree.caption1)
                .padding(.leading, 24)
                .padding(.trailing, 83)
                .padding(.bottom, 36)
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

struct TripDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailsSheetView(scooter: Scooter(battery: 82))
    }
}
