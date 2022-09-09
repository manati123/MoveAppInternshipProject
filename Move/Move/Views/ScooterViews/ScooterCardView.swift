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
    var id = UUID()
    var scooterData: Scooter
    @State var address: String = ""
    let getLocationHandler:() -> Void
    
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
                convertLocation()
            }
    }
    
    func convertLocation() {
        let location = CLLocation(latitude: scooterData.location?.coordinates?[1] ?? 0, longitude: scooterData.location?.coordinates?[0] ?? 0)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if error == nil {
                self.address = placemarks?.first?.name ?? "MOR"
            }
            else {
                print(error)
            }
        }
    }
    
    var bottomSide: some View {
        VStack{
            HStack(alignment: .top) {
                Image(ImagesEnum.clearMapPin.rawValue)
                    .foregroundColor(.neutralPurple)
                Text(self.address)
                    .font(Font.baiJamjuree.body2)
                    .foregroundColor(Color.primaryPurple)
            }
            Button() {
                print("LMAO")
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .buttonStyle(.filledButton)
            .disabled(false)
            
        }
    }
    
    var topSide: some View {
        HStack {
            Image(ImagesEnum.cardViewScooterRightOrientation.rawValue)
                .resizable()
                .scaledToFit()
            VStack {
                Text("Scooter")
                Text(verbatim: "#\(self.scooterData.number!)")
                    .font(Font.baiJamjuree.heading2)
                    .fontWeight(.bold)
                HStack {
                    switch self.scooterData.battery! {
                    case 90..<101:
                        Image(systemName: "battery.100")
                            .foregroundColor(.green)
                    case 75..<90:
                        Image(systemName: "battery.75")
                            .foregroundColor(.orange)
                    case 50..<75:
                        Image(systemName: "battery.50")
                            .foregroundColor(.yellow)
                    case 25..<50:
                        Image(systemName: "battery.25")
                            .foregroundColor(.red)
                    case 0..<25:
                        Image(systemName: "battery.0")
                    default:
                        Image(systemName: "minus.plus.batteryblock.fill")
                    }
                    Text("\(self.scooterData.battery!)")
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
            ScooterCardView(scooterData: Scooter(address: "skjdbfsdbfjs skdkjfbsdf skdfbksd sdkjfbks ksdjfb", _id: "", number: 1234, internal_id: 1234, battery: 90, locked_status: true, book_status: "", createdAt: "", updatedAt: "", __v: 123), getLocationHandler: {})
        }
//        ZStack{}
            
    }
}
