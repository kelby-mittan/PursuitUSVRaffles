//
//  ColorPallete.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import UIKit

enum ColorPallete: String {
    case offWhite = "#f9f7e3"
    case lightBlue = "#333fc1"
    case lightGreen = "#a9bd95"
    case peach = "#e2a093"
    case pink = "#c67eb2"
    case darkBlue = "#3e54c7"
    case black = "#000000"
    
    var colour: UIColor {
        guard self.rawValue.count == 7 else { return UIColor.black }
        var hexTuple: (Int,Int,Int) = (0,0,0)
        hexTuple.0 = Int(self.rawValue[self.rawValue.index(self.rawValue.startIndex, offsetBy: 1)...self.rawValue.index(self.rawValue.startIndex, offsetBy: 2)], radix: 16) ?? 0
        hexTuple.1 = Int(self.rawValue[self.rawValue.index(self.rawValue.startIndex, offsetBy: 3)...self.rawValue.index(self.rawValue.startIndex, offsetBy: 4)], radix: 16) ?? 0
        hexTuple.2 = Int(self.rawValue[self.rawValue.index(self.rawValue.startIndex, offsetBy: 5)...self.rawValue.index(self.rawValue.startIndex, offsetBy: 6)], radix: 16) ?? 0
        return UIColor(red: CGFloat(hexTuple.0) / 255.0, green: CGFloat(hexTuple.1) / 255.0, blue: CGFloat(hexTuple.2) / 255.0, alpha: 1.0)
    }
}
