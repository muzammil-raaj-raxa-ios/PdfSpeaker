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
//            OnBoarding1View()
            TabBarView()
        }
    }
}
