//
//  SpeechWaveView.swift
//  PdfSpeaker
//
//  Created by raaj on 25/10/2024.
//

import SwiftUI

struct SpeechWaveView: View {
    @State private var isAnimating = false
    
    let lineCount = 30
    let animationDuration = 1.0
    
    var body: some View {
        ZStack {
            
            HStack(spacing: 3) {
                ForEach(0..<lineCount, id: \.self) { index in
                    Rectangle()
                        .frame(width: 2, height: CGFloat.random(in: 10...50))
                }
            }
            .mask(
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black, Color.clear]),
                               startPoint: isAnimating ? .leading : .trailing,
                               endPoint: isAnimating ? .trailing : .leading)
            )
            .animation(
                Animation.linear(duration: animationDuration)
                    .repeatForever(autoreverses: true)
            )
            
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    SpeechWaveView()
}
