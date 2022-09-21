//
//  StartRideSheetView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 21.09.2022.
//

import SwiftUI

struct StartRideSheetView: View {
    var scooter: Scooter
    let onStartRide:() -> Void
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Scooter")
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.neutralPurple)
                    Text(verbatim: "#\(scooter.number!)")
                        .font(Font.baiJamjuree.heading1)
                        .foregroundColor(Color.primaryPurple)
                    BatteryView(battery: scooter.battery ?? 100)
                }
                .padding(.leading, 24)
                scooterImage
                    .padding(.leading, 25)
            }
            Button{
                
            }label: {
                Text("Start ride")
                    .font(Font.baiJamjuree.button1)
                    .padding(.horizontal, 126.5)
            }
            .buttonStyle(.filledButton)
            .padding(.top, 41)
        }
    }
    
    
    var scooterImage: some View {
        Image(ImagesEnum.cardViewScooterRightOrientation.rawValue)
            .resizable()
            .scaledToFit()
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .background(RoundedRectangle(cornerRadius: 70)
                .foregroundColor(Color.neutralGray)
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .bottom)
                .offset(x: 0, y: 45)
                .opacity(0.15)
            )
            
    }
}

struct StartRideSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StartRideSheetView(scooter: .init(number: 1234))
    }
}
