//
//  SegmentedControl+Extension.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/31/21.
//

import UIKit

extension UISegmentedControl {
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}


