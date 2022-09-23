//
//  TripDetailsSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

struct TripDetailsSheetView: View {
    @StateObject var viewModel: ViewModel
    @State var lockStatus = true
    
    init(scooter: Scooter) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter))
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
                    print("Locking")
                } label: {
                    HStack(spacing: 4) {
                        Image(self.lockStatus ? ImagesEnum.lock.rawValue : ImagesEnum.unlock.rawValue)
                        Text("Lock")
                            
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
        
        init(scooter: Scooter) {
            self.scooter = scooter
        }
        
        func lockScooter() {
            
        }
        
        func unlockScooter() {
            
        }
    }
}

struct TripDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailsSheetView(scooter: Scooter(battery: 82))
    }
}
