//
//  LicenseInformationView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 26.08.2022.
//

import SwiftUI

struct LicenseInformationView: View {
    @State private var showingSheet = false
    let onFinished:() -> Void
    var body: some View {
        GeometryReader { geometry in
            VStack {
                header
                Image("DriverLicense")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: geometry.size.height / 2)
                    .offset(x: 60, y: 0)
                VStack(spacing: 20) {
                    Text("Before you can start riding")
                        .font(Font.baiJamjuree.heading1)
                        .frame(maxWidth: geometry.size.width,maxHeight: .infinity,  alignment: .leading)
                        .padding(.leading, 24)
                        .padding(.trailing, 44)
                    
                    Text("Please take a photo or upload the front side of your driving license so we can make sure that it is valid.")
                        .font(Font.baiJamjuree.caption2)
                        .padding(.horizontal, 24)
                    
                    Button() {
    //                    onFinished()
                        print("lmao varule")
                    } label: {
                        Text("Add driving license")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.filledButton)
                    .disabled(false)
                    .animation(.default)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .sheet(isPresented: $showingSheet) {
                        optionsSheet
                    }
                }
//                .padding(.vertical, 24)
                
                
                
            }.foregroundColor(Color.primaryPurple)
                .background(.white)
                
        }
    }
    
    var optionsSheet: some View {
        VStack {
            Button() {
                print("haha")
            } label: {
                Text("Upload from gallery")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
            .disabled(false)
            .animation(.default)
            .padding(.horizontal, 24)
            
            
            Button() {
                print("haha")
            } label: {
                Text("Take photo")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
            .disabled(false)
            .animation(.default)
            .padding(.horizontal, 24)
        }
    }
    
    var header: some View {
        HStack {
            Button {
                print("PressedButton")
            }label: {
                Image("arrow-back-blue")
            }
            Spacer()
            Text("Driving License")
                .font(Font.baiJamjuree.heading3)
            Spacer()
        }.padding(24)
    }
}

struct LicenseInformationView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseInformationView(onFinished: {})
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
