//
//  SettingSheet.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import Foundation

enum SettingSheet: String, Identifiable {
    case changeVoice
    case voiceSpeed
    case appTheme
    
    var id: String { self.rawValue }
}
