//
//  ScooterCardView.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import SwiftUI

struct ScooterModel {
    let id: String?
    let batteryPercentage: Int?
    let address: String?
}

struct ScooterCardView: View {
    var id = UUID()
    var scooterData: ScooterModel
    var body: some View {
        
        ZStack {
            Image(ImagesEnum.scooterCardBackground.rawValue)
                .resizable()
                .scaledToFit()
            VStack(spacing: 24) {
                topSide
                bottomSide
            }
        }.overlay(RoundedRectangle(cornerRadius: 30).fill(.clear))
            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6, maxHeight: UIScreen.main.bounds.size.height * 0.35)
    }
    
    var bottomSide: some View {
        VStack{
            HStack(alignment: .top) {
                Image(ImagesEnum.clearMapPin.rawValue)
                    .foregroundColor(.neutralPurple)
                Text(scooterData.address!)
                    .font(Font.baiJamjuree.body2)
                    .foregroundColor(Color.primaryPurple)
            }
            Button() {
                print("LMAO")
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
            }
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
                Text(self.scooterData.id!)
                    .font(Font.baiJamjuree.heading2)
                    .fontWeight(.bold)
                HStack {
                    switch self.scooterData.batteryPercentage! {
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
                    Text("\(self.scooterData.batteryPercentage!)")
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
                        print("LMAO")
                    } label: {
                        Image(ImagesEnum.centerMapOnUserPin.rawValue)
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
        ScooterCardView(scooterData: ScooterModel(id: "#kdjfn", batteryPercentage: 100, address: "strada lu skjnfskdfn"))
        }
            
    }
}
