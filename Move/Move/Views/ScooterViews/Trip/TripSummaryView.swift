//
//  TripSummaryView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.09.2022.
//

import SwiftUI


struct TripSummaryView: View {
    let initialAddres = "Str. Avram Iancu nr. 26 Cladirea 2"
    let finalAddress = "Gradina Miko"
    let mapImage: UIImage
    @State private var frameHeight: CGFloat = 50
    @ObservedObject var mapCoordinatorViewModel: MapCoordinatorViewModel
    let onPayment:() -> Void
    
    var body: some View {
        VStack(spacing: 36) {
            Text("Trip Summary")
                .font(Font.baiJamjuree.heading2)
                .foregroundColor(Color.primaryPurple)
                .padding(.top, 54)
            
            Image(uiImage: self.mapImage)
                .centerCropped()
                .cornerRadius(26)
                .frame(width: 327, height: 172)
//            Slider(value: self.$frameHeight, in: 50...7000)
//                .padding(.horizontal, 20)
//                .resizable()
//                .scaledToFill()
//                .cornerRadius(26)
//                .frame(width: 327, height: 172, alignment: .center)
            
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
