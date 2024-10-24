//
//  OnBoarding6View.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 24/10/2024.
//

import SwiftUI
import AVFoundation

struct OnBoarding6View: View {
    //    @State private var selectedAge: AgeModel?
    @State private var isNavigationTrue = false
    @State private var showAlert = false
    @State private var progress = 0.0
    @State private var elapsedTime: Double = 0.0
    @State private var totalTime: Double = 0.0
    @State private var isSpeaking = false
    @State private var timer: Timer? = nil
    @State private var currentWordIndex = 0
    
    @State private var speechText = "Hi John Smith, a seasoned businessman at 35 years old, embodies a blend of strategic foresight and entrepreneurial zeal. With a career rooted in innovation and growth, John has carved a niche in the competitive landscape of business.\n\nHis journey began with a fervent curiosity for market dynamics and a knack for identifying emerging trends. Over the years, he has honed his skills in leadership and decision-making, navigating challenges with resilience and a forward-thinking mindset.\n\nJohn's commitment to excellence extends beyond profits, as he places equal emphasis on fostering a positive. "
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 10) {
                        ForEach(0..<6) { index in
                            RoundedRectangle(cornerRadius: 3)
                                .fill(index == 0 ? Color.onboardingDarkGreen : (index == 1 || index == 2 || index == 3 || index == 4 || index == 5 ? Color.onboardingDarkGreen : Color.onboardingLightGreen))
                                .frame(height: 2)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 50)
                    .padding([.bottom, .top], 20)
                    
                    VStack(spacing: 10) {
                        Text("Welcome to PDF Speaker🎉")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        
                        Text("Listen high quality voice")
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .foregroundColor(.onboardingGray)
                    }
                    
                    
                    
                    VStack {
                        if #available(iOS 16.0, *) {
                            Text(speechText)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .padding()
                                .padding([.leading, .trailing], 20)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: geometry.size.height * 0.5)
                                .lineLimit(nil)
                        }
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text(formatTime(elapsedTime))
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .frame(alignment: .leading)
                                
                                ProgressView(value: progress, total: 1.0)
                                    .frame(maxWidth: .infinity)
                                    .tint(.onboardingDarkGreen)
                                    .background(Color.onboardingLightGreen)
                                    .padding(.horizontal, 1)
                                
                                Text(formatTime(totalTime))
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .frame(alignment: .trailing)
                                
                            }
                            .padding()
                            
                            
                            HStack {
                                Button {
                                    
                                } label: {
                                    VStack(spacing: 0) {
                                        Image("avatar")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(Color.onboardingLightGreen, lineWidth: 2)
                                            )
                                        
                                        Text("Voice")
                                            .foregroundColor(.onboardingGray)
                                            .font(.system(size: 10))
                                    }
                                }
                                .frame(alignment: .leading)
                                
                                Button {
                                    toggleSpeech()
                                } label: {
                                    Image(systemName: isSpeaking ? "pause.fill" : "play.fill")
                                        .foregroundColor(.blackBtnText)
                                        .frame(width: 50, height: 50)
                                }
                                .background(Color.blackBtn)
                                .cornerRadius(30)
                                .frame(maxWidth: .infinity)
                                
                                Button {
                                    
                                } label: {
                                    VStack(spacing: 0) {
                                        Text("1.0x")
                                            .foregroundColor(.onboardingGray)
                                            .font(.system(size: 8))
                                            .fontWeight(.semibold)
                                            .padding(6)
                                            .background(Circle().stroke(Color.onboardingLightGreen, lineWidth: 2))
                                        
                                        Text("Speed")
                                            .foregroundColor(.onboardingGray)
                                            .font(.system(size: 10))
                                    }
                                }
                                .frame(alignment: .trailing)
                            }
                            .padding()
                        }
                        .padding([.leading, .trailing], 30)
                    }
                    .background(Color.onboardingCardGrey)
                    .cornerRadius(12)
                    .padding()
                    
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
                    .padding(.bottom, 0)
                    .padding()
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("PDF Speaker"),
                            message: Text("Please select an age."),
                            dismissButton: .default(Text(("Ok")))
                        )
                    }
                    
                    
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func toggleSpeech() {
        if isSpeaking {
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.pauseSpeaking(at: .immediate)
                isSpeaking = false
                stopTimer()
            }
        } else {
            if speechSynthesizer.isPaused {
                speechSynthesizer.continueSpeaking()
                startTimer()
            } else {
                speakText()
            }
            isSpeaking = true
        }
    }
    
    func speakText() {
        elapsedTime = 0.0
        let speechUtterance = AVSpeechUtterance(string: speechText)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let speechRate: Float = 0.5
        speechUtterance.rate = speechRate
        
        let wordsCount = Double(speechText.components(separatedBy: " ").count)
        
        let adjustedSpeedRate = speechRate == AVSpeechUtteranceDefaultSpeechRate ? 170 : 170 * Double(speechRate / AVSpeechUtteranceDefaultSpeechRate)
        totalTime = (wordsCount / adjustedSpeedRate) * 60

        
        print("Total time: \(totalTime)")
        
        speechSynthesizer.speak(speechUtterance)
        startTimer()
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            elapsedTime += 0.1
            progress = min(elapsedTime / totalTime, 1.0)
            
            print("Elapsed Time: \(elapsedTime), Progress: \(progress)")
            
            if elapsedTime >= totalTime {
                stopTimer()
                isSpeaking = false
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
   
    
}

#Preview {
    OnBoarding6View()
}
