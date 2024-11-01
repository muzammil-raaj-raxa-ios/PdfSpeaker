//
//  TextHighlightedView.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 24/10/2024.
//

import SwiftUI

struct TextHighlightedView: View {
    let words: [String]
    let currentWordIndex: Int
    let speechText: String
    
    var body: some View {
        ScrollView {
            Text(attributedString)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
        }
    }
    
    var attributedString: AttributedString {
        var result = AttributedString()
        var currentIndex = 0
        
        // Split the original text into paragraphs while preserving formatting
        let paragraphs = speechText.components(separatedBy: "\n\n")
        
        for (paragraphIndex, paragraph) in paragraphs.enumerated() {
            // Process each paragraph
            let paragraphWords = paragraph.components(separatedBy: .whitespaces)
                .filter { !$0.isEmpty }
            
            for (wordIndex, word) in paragraphWords.enumerated() {
                var attributedWord = AttributedString(word)
                
                // Highlight the current word
                if currentIndex == currentWordIndex {
                    attributedWord.backgroundColor = .onboardingLightGreen
                }
                
                result.append(attributedWord)
                
                // Add space after word if it's not the last word in the paragraph
                if wordIndex < paragraphWords.count - 1 {
                    result.append(AttributedString(" "))
                }
                
                currentIndex += 1
            }
            
            // Add paragraph breaks between paragraphs, but not after the last paragraph
            if paragraphIndex < paragraphs.count - 1 {
                result.append(AttributedString("\n\n"))
            }
        }
        
        return result
    }
}
