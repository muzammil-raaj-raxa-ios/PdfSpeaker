//
//  SelectSpeedView.swift
//  PdfSpeaker
//
//  Created by raaj on 25/10/2024.
//

import SwiftUI
import AVFoundation

struct SelectSpeedView: View {
    @State private var voiceSpeed: Float = 1.0
    @State private var isAnimating: Bool = false
    @State private var animationProgress: Float = 0.0
    @State private var wordsPerMinute: Int = 250
    
    let barHeight: [CFloat] = (0..<30).map { _ in
        CFloat.random(in: 0.2...1.0)
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var speechText: String = "Hi John Smith, a seasoned businessman at 35 years old, embodies a blend of strategic foresight and entrepreneurial zeal. With a career rooted in innovation and growth, John has carved a niche in the competitive landscape of business. His journey began with a fervent curiosity for market dynamics and a knack for identifying emerging trends. Over the years, he has honed his skills in leadership and decision-making, navigating challenges with resilience and a forward-thinking mindset. John's commitment to excellence extends beyond profits, as he places equal emphasis on fostering a positive."
    
    var speedCategory: SpeedCategory {
        SpeedCategory.category(for: voiceSpeed)
    }
    
    var productivityPercentage: Int {
        switch speedCategory {
        case .slow:
            return 10
        case .normal:
            return 30
        case .fast, .veryFast:
            return 40
        }
    }
    
    var body: some View {
        VStack {
            Text("Select an AI Enhancer Voice")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .padding()
                .padding(.top, 20)
            
            Text("\(speedCategory.rawValue)")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .padding(.bottom, 10)
            
            Text("\(productivityPercentage)% productivity boost")
                .font(.system(size: 10))
                .fontWeight(.medium)
                .padding(7)
                .foregroundColor(.onboardingDarkGreen)
                .background(.onboardingLightGreen)
                .cornerRadius(10)
            
            HStack(spacing: 30) {
                Button {
                    decreaseSpeed()
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 10, height: 10)
                        .foregroundColor(.blackBtn)
                }
                .frame(width: 25, height: 25)
                .background(.onboardingLightGreen)
                .cornerRadius(5)
                
                Text(String(format: "%.1f x", voiceSpeed))
                    .font(.system(size: 24))
                    .fontWeight(.regular)
                
                Button {
                    inceaseSpeed()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 10, height: 10)
                        .foregroundColor(.blackBtn)
                }
                .frame(width: 25, height: 25)
                .background(.onboardingLightGreen)
                .cornerRadius(5)
                
            }
            .padding(.top, 40)
            
            Text("\(wordsPerMinute) words per minutes")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 12))
                .fontWeight(.regular)
                .padding(.top, 30)
            
            Rectangle()
                .fill(Color.blackBtnText)
                .cornerRadius(10)
                .frame(width: 200, height: 40)
                .padding()
                .overlay(
                    GeometryReader { geometry in
                        let lineWidth = geometry.size.width * CGFloat(animationProgress)
                        
                        HStack(spacing: 4) {
                            ForEach(0..<barHeight.count, id: \.self) { index in
                                Rectangle()
                                    .fill(lineWidth > geometry.size.width * CGFloat(index) / CGFloat(barHeight.count) ? .blackBtnText : Color.soundWave)
                                    .frame(width: 2, height: geometry.size.height * CGFloat(barHeight[index]) * 0.5)
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(
                            Color.blackBtn
                                .frame(width: lineWidth, height: 40)
                                .cornerRadius(10),
                            alignment: .leading
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                )
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                        animationProgress = 1.0
                    }
                    startSpeech()
                }
            
            
            Button {
                
            } label: {
                Text("Next")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.blackBtnText)
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
            .background(Color.blackBtn)
            .cornerRadius(30)
            .padding()
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.avatarBG)
    }
}

extension SelectSpeedView {
    func inceaseSpeed() {
        voiceSpeed = min(voiceSpeed + 0.1, 2.0)
        wordsPerMinute = min(wordsPerMinute + 10, 350)
        updateSpeech()
    }
    
    func decreaseSpeed() {
        voiceSpeed = max(voiceSpeed - 0.1, 0.5)
        wordsPerMinute = max(wordsPerMinute - 10, 200)
        updateSpeech()
    }
    
    private func startSpeech() {
        let utterance = AVSpeechUtterance(string: speechText)
        utterance.rate = mapVoiceSpeedToRate(voiceSpeed)
        speechSynthesizer.speak(utterance)
    }
    
    private func updateSpeech() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        startSpeech()
    }
    
    private func mapVoiceSpeedToRate(_ voiceSpeed: Float) -> Float {
        // Mapping 1.0 displayed speed to 0.5 rate internally
        // Mapping 2.0 displayed speed to 2.5 rate internally
        return 0.5 + (voiceSpeed - 1.0) * 2.0
    }
    
}

#Preview {
    SelectSpeedView()
}
