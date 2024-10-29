//
//  AppThemeModel.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import SwiftUI

struct AppThemeModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String
    let type: ThemeType
}


enum ThemeType: String {
    case system = "system"
    case light = "light"
    case dark = "dark"
}
