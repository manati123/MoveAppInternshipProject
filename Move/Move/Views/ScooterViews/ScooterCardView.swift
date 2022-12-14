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
    
    @StateObject private var viewModel: ViewModel
    let getLocationHandler:() -> Void
    let showSheet:() -> Void
    
    init(scooter: Scooter, getLocationHandler:@escaping () -> Void, showSheet:@escaping () -> Void) {
        self._viewModel = StateObject(wrappedValue: ViewModel(scooter: scooter))
        self.getLocationHandler = getLocationHandler
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
    
    //TODO: smaller spacing
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
                self.showSheet()
                
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .buttonStyle(.filledButton)
//            .disabled(s)
            
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
                    case 81..<101:
                        Image(ImagesEnum.battery100.rawValue)
                            .foregroundColor(.green)
                    case 60..<81:
                        Image(ImagesEnum.battery80.rawValue)
                            .foregroundColor(.orange)
                    case 40..<60:
                        Image(ImagesEnum.battery50.rawValue)
                            .foregroundColor(.yellow)
                    case 20..<40:
                        Image(ImagesEnum.battery20.rawValue)
                            .foregroundColor(.red)
                    case 0..<20:
                        Image(ImagesEnum.battery0.rawValue)
                    default:
                        Image(ImagesEnum.batteryCharging.rawValue)
                    }
                    Text("\(self.viewModel.scooterData.battery!)%")
                        .font(Font.baiJamjuree.smallText)
                }
                HStack(spacing: 24) {
                    Button() {
                        ScooterAPI().pingScooter(scooterId: "61fa56c7e47c4209abcd7837", token: UserDefaultsService().loadTokenFromDefaults())
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
            ScooterCardView(scooter: Scooter(address: "skjdbfsdbfjs skdkjfbsdf skdfbksd sdkjfbks ksdjfb", _id: "", number: 1234, battery: 90, lockedStatus: true, bookStatus: "", createdAt: "", updatedAt: "", __v: 123), getLocationHandler: {}, showSheet: {})
        }
    }
}
