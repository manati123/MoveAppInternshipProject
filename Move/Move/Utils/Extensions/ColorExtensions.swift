//
//  ColorExtensions.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 18.08.2022.
//

import Foundation
import SwiftUI

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}

extension Color {
    public static var primaryPurple: Color {
        return Color(0x3B1159)
    }
    
    public static var primaryBlue: Color {
        return Color(0x210B50)
    }
    
    public static var neutralGray: Color {
        return Color(0x9D9D9D)
    }
    
    public static var neutralPink: Color {
        return Color(0xF4BDCC)
    }
    
    public static var neutralPurple: Color {
        return Color(0xB2AAC2)
    }
    
    public static var neutralGray2: Color {
        return Color(0xF4F2F6)
    }
    
    public static var neutralWhite: Color {
        return Color(0xFFFFFF)
    }
    
    public static var accentPink: Color {
        return Color(0xE53062)
    }
}
