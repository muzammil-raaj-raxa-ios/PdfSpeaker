//
//  ThemeManager.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeType = AppThemeView.loadTheme()
    
    func applyTheme(_ theme: ThemeType) {
        selectedTheme = theme
        saveTheme(theme)
    }
    
    private func saveTheme(_ theme: ThemeType) {
        UserDefaults.standard.set(theme.rawValue, forKey: "selectedTheme")
    }
}
