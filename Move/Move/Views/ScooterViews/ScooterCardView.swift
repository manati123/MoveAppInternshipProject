//
//  ScooterCardView.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import SwiftUI

struct ScooterCardView: View {
    var id = UUID()
    var body: some View {
        
        ZStack {
            Image("ScooterCardBackground")
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
                Image("ClearPin")
                    .foregroundColor(.neutralPurple)
                Text("Str. Lotrului Numarul \n 6, Brezoi")
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
            Image("CardViewScooter")
                .resizable()
                .scaledToFit()
            VStack {
                Text("Scooter")
                Text("ScooterTag")
                    .font(Font.baiJamjuree.heading2)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "battery.100")
                    Text("100%")
                        .font(Font.baiJamjuree.smallText)
                }
                HStack {
                    Button() {
                        print("LMAO")
                    } label: {
                        Image("ScooterRingPin")
                    }
                    .buttonStyle(.simpleMapButton)
                    .disabled(false)
                    
                    
                    Button() {
                        print("LMAO")
                    } label: {
                        Image("ScooterLocationPin")
                    }
                    .buttonStyle(.simpleMapButton)
                    .disabled(false)
                    
                }
            }
            .foregroundColor(Color.primaryPurple)
        }
    }
}

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
        ScooterCardView()
        }
            
    }
}
