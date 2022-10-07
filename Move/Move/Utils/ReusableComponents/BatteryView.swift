//
//  BatteryView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 21.09.2022.
//

import SwiftUI

struct BatteryView: View {
    @State var battery: Int
    var body: some View {
        HStack {
            switch self.battery {
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
            Text("\(self.battery)%")
                .font(Font.baiJamjuree.smallText)
        }
    }
    
    
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(battery: 80)
    }
}
