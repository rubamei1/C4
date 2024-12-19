//
//  ColorExtension.swift
//  C4
//
//  Created by Ruba Meshal Alqahtani on 19/12/2024.
//

import Foundation
import SwiftUI

extension Color {
    init(from colorName: String) {
        switch colorName.lowercased() {
        case "pink": self = .pink
        case "white": self = .white
        case "yellow": self = .yellow
        case "black": self = .black
        default: self = .gray // Fallback color
        }
    }
}
