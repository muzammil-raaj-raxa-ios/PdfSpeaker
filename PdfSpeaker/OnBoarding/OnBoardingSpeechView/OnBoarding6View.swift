//
//  OnBoarding6View.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 24/10/2024.
//

import SwiftUI
import AVFoundation

struct OnBoarding6View: View {
    @StateObject private var speechDelegateWrapper = SpeechDelegateWrapper()
    @State private var avatarImage: UIImage = UIImage(named: "avatar1")!
    @State private var isNavigationTrue = false
    @State private var showAlert = false
    @State private var progress = 0.0
    @State private var elapsedTime: Double = 0.0
    @State private var totalTime: Double = 0.0
    @State private var isSpeaking = false
    @State private var timer: Timer? = nil
    @State private var words: [String] = []
    @State private var currentWordIndex = -1
    @State private var isAvatarViewShowing: Bool = false
    @State private var isSpeedViewShowing: Bool = false
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    //formatted speech text
    var speechText: String {
            """
            Hi John Smith, a seasoned businessman at 35 years old, embodies a blend of strategic foresight and entrepreneurial zeal. With a career rooted in innovation and growth, John has carved a niche in the competitive landscape of business.
            
            His journey began with a fervent curiosity for market dynamics and a knack for identifying emerging trends. Over the years, he has honed his skills in leadership and decision-making, navigating challenges with resilience and a forward-thinking mindset.
            
            John's commitment to excellence extends beyond profits, as he places equal emphasis on fostering a positive.
            """
    }
    
    var isCompleted: Bool {
        return elapsedTime >= totalTime
    }
    
    // to chech and play sound even if device is muted
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
    }
    
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
                    
                    
                    // Speech Text
                    VStack {
                        if #available(iOS 16.0, *) {
                            TextHighlightedView(
                                words: words,
                                currentWordIndex: currentWordIndex,
                                speechText: speechText
                            )
                            .font(.system(size: 16))
                            .fontWeight(.regular)
                            .padding()
                            .padding([.leading, .trailing], 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: geometry.size.height * 0.5)
                            .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
                        // Remaining time, progress view and total time
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
                                // Select avatar
                                if #available(iOS 16.0, *) {
                                    Button {
                                        isAvatarViewShowing.toggle()
                                    } label: {
                                        VStack(spacing: 0) {
                                            Image(uiImage: avatarImage)
                                                .resizable()
                                                .frame(width: 27, height: 27)
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
                                    .sheet(isPresented: $isAvatarViewShowing) {
                                        SelectAvatarView(selectedAvatarImage: $avatarImage)
                                            .presentationDetents([.height(450)])
                                            .presentationDragIndicator(.visible)
                                            .cornerRadius(20)
                                    }
                                }
                                
                                
                                // Pause and play button
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
                                
                                
                                // select speed button
                                if #available(iOS 16.0, *) {
                                    Button {
                                        isSpeedViewShowing = true
                                    } label: {
                                        VStack(spacing: 0) {
                                            Text("1.0x")
                                                .foregroundColor(.onboardingGray)
                                                .font(.system(size: 8))
                                                .fontWeight(.semibold)
                                                .padding(7)
                                                .background(Circle().stroke(Color.onboardingLightGreen, lineWidth: 2))
                                            
                                            Text("Speed")
                                                .foregroundColor(.onboardingGray)
                                                .font(.system(size: 10))
                                        }
                                    }
                                    .frame(alignment: .trailing)
                                    .sheet(isPresented: $isSpeedViewShowing) {
                                        SelectSpeedView()
                                            .presentationDetents([.height(470)])
                                            .presentationDragIndicator(.visible)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding([.leading, .trailing], 30)
                    }
                    .background(Color.onboardingCardGrey)
                    .cornerRadius(12)
                    .padding()
                    
                    
                    // Next button
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
            .onAppear {
                words = preprocessText(speechText)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
}

extension OnBoarding6View {
    class SpeechDelegateWrapper: ObservableObject {
        var delegate: SpeechDelegate?
    }
    
    
    // function to play and pause
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
        currentWordIndex = -1
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }
        
        let utterance = AVSpeechUtterance(string: speechText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let speechRate: Float = 0.5
        utterance.rate = speechRate
        
        // Improve speech quality
        utterance.volume = 1.0
        utterance.pitchMultiplier = 1.0
        utterance.prefersAssistiveTechnologySettings = false
        
        // Add natural pauses
        utterance.preUtteranceDelay = 0.2
        utterance.postUtteranceDelay = 0.2
        
        words = preprocessText(speechText)
        
        // Calculate duration before starting speech
        totalTime = calculateSpeechDuration(text: speechText, rate: speechRate)
        print("Debug: Initial total time calculation: \(totalTime)")
        
        speechDelegateWrapper.delegate = SpeechDelegate(
            words: words,
            originalText: speechText
        ) { index in
            self.currentWordIndex = index
        }
        
        speechSynthesizer.delegate = speechDelegateWrapper.delegate
        speechSynthesizer.speak(utterance)
        startTimer()
    }
    
    func calculateSpeechDuration(text: String, rate: Float) -> Double {
        let wordsCount = Double(text.components(separatedBy: .whitespaces)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .count)
        
        print("Debug: Words count in calculation: \(wordsCount)")
        
        let baseWPM: Double = 170.0
        let adjustedWPM = baseWPM * (Double(rate) * 2.0)
        
        // Calculate minutes needed for speaking
        let speakingMinutes = wordsCount / adjustedWPM
        
        // Convert to seconds
        var totalSeconds = speakingMinutes * 60.0
        
        // Add time for punctuation pauses (reduced pause time)
        let punctuationMarks = CharacterSet(charactersIn: ",.!?")
        let punctuationCount = Double(text.unicodeScalars.filter { punctuationMarks.contains($0) }.count)
        let pauseTimePerPunctuation = 0.15 // Reduced from 0.2 to match actual pauses
        let pauseTime = punctuationCount * pauseTimePerPunctuation
        
        totalSeconds += pauseTime
        
        // Reduced buffer time
        totalSeconds += 1.0
        
        print("Debug: Calculated total seconds: \(totalSeconds)")
        print("Debug: Speaking minutes: \(speakingMinutes)")
        print("Debug: Pause time: \(pauseTime)")
        
        return max(totalSeconds, 1.0)
    }
    
    func preprocessText(_ text: String) -> [String] {
        return text.components(separatedBy: .newlines)
            .flatMap { paragraph -> [String] in
                let words = paragraph.components(separatedBy: .whitespaces)
                    .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                return words.isEmpty ? [] : words + (paragraph.hasSuffix("\n") ? ["\n"] : [])
            }
    }
    
    func startTimer() {
        stopTimer()
        
        if totalTime <= 0 {
            totalTime = calculateSpeechDuration(text: speechText, rate: 0.5)
            print("Debug: Corrected total time: \(totalTime)")
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.elapsedTime < self.totalTime {
                self.elapsedTime += 0.1
                
                // Ensure progress never exceeds 1.0
                self.progress = min(self.elapsedTime / self.totalTime, 1.0)
                
                // Debug timing information
                if Int(self.elapsedTime * 10) % 50 == 0 { // Print every 5 seconds
                    print("Debug: Current progress - Elapsed: \(self.formatTime(self.elapsedTime)), Total: \(self.formatTime(self.totalTime)), Progress: \(self.progress)")
                }
            } else {
                self.stopTimer()
                self.isSpeaking = false
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
    
    func debugSpeechInfo() {
        let wordCount = speechText.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .count
        
        let punctuationCount = speechText.unicodeScalars
            .filter { CharacterSet(charactersIn: ",.!?").contains($0) }
            .count
        
        print("Word count: \(wordCount)")
        print("Punctuation count: \(punctuationCount)")
        print("Calculated duration: \(totalTime) seconds")
        print("Speech rate: \(AVSpeechUtteranceDefaultSpeechRate)")
    }
    
    func cleanup() {
        debugSpeechInfo()
        stopTimer()
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }
    
    func onDisappear() {
        cleanup()
    }
}

#Preview {
    OnBoarding6View()
}
