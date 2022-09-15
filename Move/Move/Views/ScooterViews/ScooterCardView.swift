//
//  ScooterCardView.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import SwiftUI
import CoreLocation

struct ScooterModel {
    let id: String?
    let batteryPercentage: Int?
    let address: String?
}

struct ScooterCardView: View {
    var isEnabled: Bool
    @StateObject private var viewModel: ViewModel
    let getLocationHandler:() -> Void
    let showSheet:() -> Void
    
    init(isEnabled: Bool, scooter: Scooter, getLocationHandler:@escaping () -> Void, showSheet:@escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter))
        self.getLocationHandler = getLocationHandler
        self.isEnabled = isEnabled
        self.showSheet = showSheet
    }
    var body: some View {
        ZStack {
            Image(ImagesEnum.scooterCardBackground.rawValue)
                .resizable()
                .scaledToFill()
            VStack(spacing: 24) {
                topSide
                bottomSide
            }
        }.overlay(RoundedRectangle(cornerRadius: 30).fill(.clear))
            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.7, maxHeight: UIScreen.main.bounds.size.height * 0.35)
            .onAppear {
                self.viewModel.convertLocation()
            }
            
    }
    var bottomSide: some View {
        VStack{
            HStack(alignment: .top) {
                Image(ImagesEnum.clearMapPin.rawValue)
                    .foregroundColor(.neutralPurple)
                Text(self.viewModel.address)
                    .font(Font.baiJamjuree.body2)
                    .foregroundColor(Color.primaryPurple)
            }
            Button() {
                print("LMAO")
                self.showSheet()
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .buttonStyle(.filledButton)
            .disabled(self.isEnabled)
            
        }
    }
    var topSide: some View {
        HStack {
            Image(ImagesEnum.cardViewScooterRightOrientation.rawValue)
                .resizable()
                .scaledToFit()
            VStack {
                Text("Scooter")
                Text(verbatim: "#\(self.viewModel.scooterData.number!)")
                    .font(Font.baiJamjuree.heading2)
                    .fontWeight(.bold)
                HStack {
                    switch self.viewModel.scooterData.battery! {
                    case 80..<101:
                        Image(systemName: "battery.100")
                            .foregroundColor(.green)
                    case 60..<80:
                        Image(systemName: "battery.75")
                            .foregroundColor(.orange)
                    case 40..<60:
                        Image(systemName: "battery.50")
                            .foregroundColor(.yellow)
                    case 20..<40:
                        Image(systemName: "battery.25")
                            .foregroundColor(.red)
                    case 0..<20:
                        Image(systemName: "battery.0")
                    default:
                        Image(systemName: "minus.plus.batteryblock.fill")
                    }
                    Text("\(self.viewModel.scooterData.battery!)")
                        .font(Font.baiJamjuree.smallText)
                }
                HStack(spacing: 24) {
                    Button() {
                        print("LMAO")
                    } label: {
                        Image(ImagesEnum.ringScooterPin.rawValue)
                    }
                    .buttonStyle(.simpleMapButton)
                    .disabled(false)
                    
                    
                    Button() {
                        getLocationHandler()
                    } label: {
                        Image(ImagesEnum.scooterLocationPin.rawValue)
                    }
                    
                    .buttonStyle(.simpleMapButton)
                    .disabled(false)
                    
                    
                }.padding(.trailing, 24)
            }
            .foregroundColor(Color.primaryPurple)
        }
    }
    
    
}

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ScooterCardView(isEnabled: false, scooter: Scooter(address: "skjdbfsdbfjs skdkjfbsdf skdfbksd sdkjfbks ksdjfb", _id: "", number: 1234, internal_id: 1234, battery: 90, lockedStatus: true, bookStatus: "", createdAt: "", updatedAt: "", __v: 123), getLocationHandler: {}, showSheet: {})
        }
    }
}
