//
//  TripSummaryView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.09.2022.
//

import SwiftUI


struct TripSummaryView: View {
//    let mapSnapshot: UIImage
    let initialAddres = "Str. Avram Iancu nr. 26 Cladirea 2"
    let finalAddress = "Gradina Miko"
//    let travelTime = "00:12 min"
//    @Binding var tripDetails: TripDetailsModel
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    let onPayment:() -> Void
//    let distance = 0.0
//    init(mapSnapshot: UIImage) {
//        self.mapSnapshot = mapSnapshot
//    }
    
    var body: some View {
        VStack(spacing: 36) {
            Text("Trip Summary")
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
                .padding(.top, 54)
            
            RoundedRectangle(cornerRadius: 26)
                .frame(maxWidth: 327, maxHeight: 172)
                .overlay(Image("MockMapImage")
                    .cornerRadius(26)
                )
            
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("From")
                        .padding(.trailing, 274)
                        .font(Font.baiJamjuree.caption2)
                        .foregroundColor(Color.neutralGray)
                    Text(initialAddres)
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .padding(.leading, 20)
                .padding(.top, 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("To")
                        .font(Font.baiJamjuree.caption2)
                        .foregroundColor(Color.neutralGray)
                    Text(finalAddress)
                        .font(Font.baiJamjuree.caption1)
                        .foregroundColor(Color.primaryPurple)
                }
                .padding(.leading, 20)
                .padding(.bottom, 12)
            }.background(
                RoundedRectangle(cornerRadius: 26)
//                    .frame(width: .infinity, height: 132)
                    .foregroundColor(Color.neutralGray.opacity(0.15)))
            TripTimeAndDistanceView(mapCoordinatorViewModel: self.mapCoordinatorViewModel ,timeIsRunning: .constant(false))
            Spacer()
            
            Button{
                print("MONEY")
                onPayment()
            }label: {
                Text("Pay with \(Image(systemName: "apple.logo"))Pay")
            }
            .buttonStyle(.applePayButton)
            .padding(.bottom, 46)
            
        }
    }
}

//struct TripSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
////        TripSummaryView(mapSnapshot: .init(named: ImagesEnum.scooterLocationPin.rawValue)!)
//        TripSummaryView()
//    }
//}
