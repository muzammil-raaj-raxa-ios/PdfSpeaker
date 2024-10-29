//
//  SelectSpeedDelegate.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI
import AVFoundation

class SelectSpeedDelegate: NSObject, AVSpeechSynthesizerDelegate {
    @Binding var animationProgress: Float
    
    init(animationProgress: Binding<Float>) {
        _animationProgress = animationProgress
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.animationProgress = 0.0
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.animationProgress = 0.0
        }
    }
}
