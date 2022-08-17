//
//  TextExtensions.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 16.08.2022.
//

import Foundation
import SwiftUI

extension Text {
    func Heading1() -> some View{
        self.font(.custom("BaiJamjuree-Bold", fixedSize: 32))
    }
    
    func Heading2() -> some View {
        self.font(.custom("BaiJamjuree-Medium",fixedSize: 20))
    }
    
    func Heading3() -> some View {
        self.font(.custom("BaiJamjuree-Semibold",fixedSize: 17))
    }
    
    func Heading4() -> some View {
        self.font(.custom("BaiJamjuree-Medium",fixedSize: 16))
    }
    
    func Button1() -> some View {
        self.font(.custom("BaiJamjuree-Bold", fixedSize: 16))
    }
    
    func Button2() -> some View {
        self.font(.custom("BaiJamjuree-Medium",fixedSize: 14))
    }
    
    func Caption1() -> some View {
        self.font(.custom("BaiJamjuree-Semibold",fixedSize: 16))
    }
    
    func Caption2() -> some View {
        self.font(.custom("BaiJamjuree-Regular",fixedSize: 16))
    }
    
    func Body1() -> some View {
        self.font(.custom("BaiJamjuree-Medium", fixedSize: 16))
    }
    
    func Body2() -> some View {
        self.font(.custom("BaiJamjuree-Medium", fixedSize: 14))
    }
    
    func SmallText() -> some View {
        self.font(.custom("BaiJamjuree-Regular", size: 16))
    }
}
