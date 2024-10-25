import SwiftUI
import AVFoundation

class SpeechDelegate: NSObject, AVSpeechSynthesizerDelegate {
    private let words: [String]
    private let originalText: String
    private let onSpokenWord: (Int) -> Void
    private var currentPosition: Int = 0
    private var lastProcessedRange: NSRange?
    
    init(words: [String], originalText: String, onSpokenWord: @escaping (Int) -> Void) {
        self.words = words
        self.originalText = originalText
        self.onSpokenWord = onSpokenWord
        super.init()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        if lastProcessedRange == nil || characterRange.location < lastProcessedRange!.location {
            currentPosition = 0
        }
        
        let spokenText = (utterance.speechString as NSString)
            .substring(with: characterRange)
        
        let spokenWord = spokenText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: .punctuationCharacters)
            .lowercased()
        
        guard !spokenWord.isEmpty else { return }
        
        while currentPosition < words.count {
            let currentWord = words[currentPosition]
                .trimmingCharacters(in: .punctuationCharacters)
                .lowercased()
            
            if currentWord == spokenWord {
                DispatchQueue.main.async { [weak self] in
                    self?.onSpokenWord(self?.currentPosition ?? -1)
                }
                break
            }
            currentPosition += 1
        }
        
        lastProcessedRange = characterRange
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.currentPosition = 0
            self?.lastProcessedRange = nil
            self?.onSpokenWord(-1)
    
            print("Debug: Speech completed naturally")
        }
        
    }
}
