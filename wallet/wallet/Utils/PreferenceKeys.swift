//
//  PreferenceKeys.swift
//  wallet
//
//  Created by Edvaldo Martins on 13/11/2023.
//

import Foundation
import SwiftUI

struct ScrollPreferenceKeys: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
    }
}
