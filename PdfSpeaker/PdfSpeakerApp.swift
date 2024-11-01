//
//  PdfSpeakerApp.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI
import AVFoundation

@main
struct PdfSpeakerApp: App {
    
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var tabBarVisibilityManager = TabBarVisibility()
    
    // to check and play sound even if device is muted
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            OnBoarding1View()
//            TabBarView()
                .environmentObject(themeManager)
                .environmentObject(tabBarVisibilityManager)
                .preferredColorScheme(
                    themeManager.selectedTheme == .light ? .light : themeManager.selectedTheme == .dark ? .dark : nil
                )
        }
    }
}
