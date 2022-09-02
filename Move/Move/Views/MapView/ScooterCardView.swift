//
//  ScooterCardView.swift
//  Move
//
//  Created by Silviu Preoteasa on 01.09.2022.
//

import SwiftUI

struct ScooterCardView: View {
    var body: some View {
        
        ZStack {
            Image("ScooterCardBackground")
                .resizable()
                .scaledToFit()
            VStack(spacing: 24) {
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
                                Text("Unlock")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.filledButton)
                            .disabled(false)
                            .animation(.default)
                            
                            Button() {
                                print("LMAO")
                            } label: {
                                Text("Unlock")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.filledButton)
                            .disabled(false)
                            .animation(.default)
                        }
                    }
                    .foregroundColor(Color.primaryPurple)
                }
                VStack{
                    Text("smtsmt text location")
                    Button() {
                        print("LMAO")
                    } label: {
                        Text("Unlock")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(false)
                    .animation(.default)
                }
            }
        }.overlay(RoundedRectangle(cornerRadius: 30).fill(.clear))
        
        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6, maxHeight: UIScreen.main.bounds.size.height * 0.35)
        
        
        
    }
}

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterCardView()
    }
}
