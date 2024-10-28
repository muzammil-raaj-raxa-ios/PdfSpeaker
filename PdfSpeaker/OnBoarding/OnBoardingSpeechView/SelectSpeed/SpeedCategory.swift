//
//  SpeedType.swift
//  PdfSpeaker
//
//  Created by raaj on 28/10/2024.
//

import SwiftUI

enum SpeedCategory: String {
    case slow = "Slow"
    case normal = "Normal"
    case fast = "Fast"
    case veryFast = "Very Fast"
    
    static func category(for speed: Float) -> SpeedCategory {
        switch speed {
        case 0.5...0.9:
            return .slow
        case 1.0...1.5:
            return .normal
        case 1.6...2.0:
            return .fast
        default:
            return .normal
        }
    }
}
