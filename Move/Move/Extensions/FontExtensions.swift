//
//  FontExtensions.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 17.08.2022.
//

import Foundation
import SwiftUI

extension Font {
    struct BaiJamjuree {
        let heading1 = Font.custom("BaiJamjuree-Bold", fixedSize: 32)
        let heading3 = Font.custom("BaiJamjuree-Semibold",fixedSize: 17)
        let heading2 = Font.custom("BaiJamjuree-Medium", fixedSize:  20)
        let heading4 = Font.custom("BaiJamjuree-Medium", fixedSize: 16)
        let button1 = Font.custom("BaiJamjuree-Bold", fixedSize: 16)
        let button2 = Font.custom("BaiJamjuree-Medium", fixedSize: 14)
        let caption1 = Font.custom("BaiJamjuree-Semibold", fixedSize: 16)
        let caption2 = Font.custom("BaiJamjuree-Regular", fixedSize: 16)
        let body1 = Font.custom("BaiJamjuree-Medium", fixedSize: 16)
        let body2 = Font.custom("BaiJamjuree-Medium", fixedSize: 14)
        let smallText = Font.custom("BaiJamjuree-Regular", fixedSize: 16)
    }
    static let baiJamjuree = BaiJamjuree()
}
