//
//  RideInformationCard.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI

struct RideInformation {
    let initialAddress: String
    let finishAddress: String
    let distance: Double
    let time: String
}

struct RideInformationCard: View {
    let ride: RideInformation
    var body: some View {
        rideInformation
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(Color.primaryPurple, lineWidth: 2)
                    RoundedRectangle(cornerRadius: 26)
                        .foregroundColor(Color.neutralGray2)
                        .padding([.leading, .bottom, .top], 1)
                        .padding(.trailing, 109)
                }
            )
            .padding(.horizontal, 40)
            
        
        
        
    }
    
    var rideInformation: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(spacing: 95) {
                VStack(alignment: .leading) {
                    Text("From")
                        .font(Font.baiJamjuree.heading4)
                        .foregroundColor(Color.neutralGray)
                    Text(ride.initialAddress)
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                VStack {
                    Text("Travel time")
                        .font(Font.baiJamjuree.heading4)
                        .foregroundColor(Color.neutralGray)
                    Text(ride.time)
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
            }.frame(maxWidth: .infinity)
            HStack(spacing: 95) {
                VStack(alignment: .leading) {
                    Text("To")
                        .font(Font.baiJamjuree.heading4)
                        .foregroundColor(Color.neutralGray)
                    Text(ride.finishAddress)
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                VStack {
                    Text("Distance")
                        .font(Font.baiJamjuree.heading4)
                        .foregroundColor(Color.neutralGray)
                    Text(verbatim: "\(ride.distance) km")
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
            }.frame(maxWidth: .infinity)
        }
        .padding(10)
        .frame(maxWidth: 327, maxHeight: 160)
        //        .padding(.vertical, 10)
    }
}

struct RideInformationCard_Previews: PreviewProvider {
    static var previews: some View {
        RideInformationCard(ride: RideInformation(initialAddress: "Brezoi", finishAddress: "CLOOOJ", distance: 203.4, time: "2:35 h"))
    }
}
