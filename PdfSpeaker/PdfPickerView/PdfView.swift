//
//  PdfPickerVie.swift
//  PdfSpeaker
//
//  Created by r a a j on 01/11/2024.
//

import SwiftUI
import AVFoundation

struct PdfView: View {
    @EnvironmentObject var tabBarVisiblity: TabBarVisibility
    @Environment(\.presentationMode) var popView: Binding<PresentationMode>
    @StateObject private var speechDelegateWrapper = SpeechDelegateWrapper()
    
    @State private var progress = 0.0
    @State private var isAvatarViewShowing: Bool = false
    @State private var isSpeedViewShowing: Bool = false
    @State private var isAddNotesViewShowing: Bool = false
    @State private var avatarImage: UIImage = UIImage(named: "avatar1")!
    @State private var avatarName: String = "Katherine"
    @State private var selectedVoiceSpeed: String = "1.0x"
    @State private var isSpeaking = false
    @State private var words: [String] = []
    @State private var currentWordIndex = -1
    @State private var elapsedTime: Double = 0.0
    @State private var totalTime: Double = 0.0
    @State private var timer: Timer? = nil
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var notes: [String] = []
    var isCompleted: Bool {
        return elapsedTime >= totalTime
    }
    
    var speechText: String {
            """
            Hi John Smith, a seasoned businessman at 35 years old, embodies a blend of strategic foresight and entrepreneurial zeal. With a career rooted in innovation and growth, John has carved a niche in the competitive landscape of business.
            
            His journey began with a fervent curiosity for market dynamics and a knack for identifying emerging trends. Over the years, he has honed his skills in leadership and decision-making, navigating challenges with resilience and a forward-thinking mindset.
            
            John's commitment to excellence extends beyond profits, as he places equal emphasis on fostering a positive.
            """
    }
    
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                VStack {
                    
                    // TOP nav bar
                    HStack {
                        Button {
                            popView.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blackBtn)
                                .frame(width: 17, height: 17)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.onboardingCardGrey)
                                        .frame(width: 25, height: 25)
                                        .cornerRadius(6)
                                )
                        }
                        .padding(.leading, 25)
                        
                        Text("Back")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button {
                                
                            } label: {
                                Image(systemName: "ecg.text.page")
                                    .foregroundColor(.onboardingGray)
                                    .frame(width: 25, height: 25)
                                
                            }
                            
                            if !notes.isEmpty {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "text.document")
                                        .foregroundColor(.onboardingGray)
                                        .frame(width: 25, height: 25)
                                    
                                }
                            }
                            
                            
                            Button {
                                isAddNotesViewShowing = true
                            } label: {
                                Image(systemName: "document.badge.plus")
                                    .foregroundColor(.onboardingGray)
                                    .frame(width: 25, height: 25)
                                
                            }
                        }
                        .padding(.trailing, 20)
                        .sheet(isPresented: $isAddNotesViewShowing) {
                            AddNotesView()
                                .presentationDetents([.height(450)])
                                .presentationDragIndicator(.visible)
                                .cornerRadius(20)
                        }
                        
                    }
                    .padding([.top, .bottom], 10)
                    
                    
                    
                    VStack {
                        VStack {
                            TextHighlightedView(
                                words: words,
                                currentWordIndex: currentWordIndex,
                                speechText: speechText
                            )
                            .foregroundColor(.blackBtn)
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(4)
                        }
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.onboardingCardGrey)
                    
                    
                    
                    // Bottom View
                    VStack {
                        Text("PDF Speaker.pdf")
                            .foregroundColor(.blackBtn)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                        
                        HStack {
                            Text(formatTime(elapsedTime))
                                .foregroundColor(.onboardingGray)
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .frame(alignment: .leading)
                            
                            GeometryReader { geometry in
                                let progressWidth = geometry.size.width
                                ProgressView(value: progress, total: 1.0)
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .tint(.onboardingDarkGreen)
                                    .background(Color.onboardingLightGreen)
                                    .padding(.horizontal, 5)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.onboardingDarkGreen, lineWidth: 2)
                                            .background(Circle().fill(Color.white))
                                            .frame(width: 10, height: 10)
                                            .offset(x: progressWidth * CGFloat(progress) - 5),
                                        alignment: .leading
                                    )
                            }
                            .frame(height: 1)
                            
                            Text(formatTime(totalTime))
                                .foregroundColor(.onboardingGray)
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .frame(alignment: .trailing)
                            
                        }
                        .padding()
                        
                        
                        HStack {
                            // Select avatar
                            Button {
                                if speechSynthesizer.isSpeaking {
                                    speechSynthesizer.pauseSpeaking(at: .immediate)
                                    isSpeaking = false
                                    stopTimer()
                                }
                                isAvatarViewShowing.toggle()
                            } label: {
                                VStack(spacing: 0) {
                                    Image(uiImage: avatarImage)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color.onboardingDarkGreen, lineWidth: 1)
                                        )
                                    
                                    Text("Voice")
                                        .foregroundColor(.blackBtn)
                                        .font(.system(size: 10))
                                        .fontWeight(.regular)
                                }
                                .frame(width: 70, height: 40)
                                .background(.onboardingCardGrey)
                                .cornerRadius(10)
                            }
                            .frame(alignment: .leading)
                            .sheet(isPresented: $isAvatarViewShowing) {
                                SelectVoiceView(selectedAvatarName: $avatarName, selectedAvatarImage: $avatarImage)
                                    .presentationDetents([.height(450)])
                                    .presentationDragIndicator(.visible)
                                    .cornerRadius(20)
                            }
                            
                            
                            
                            // Pause and play button
                            HStack(spacing: 20) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "backward.fill")
                                        .foregroundColor(.onboardingGray)
                                        .frame(width: 25, height: 20)
                                }
                                
                                
                                Button {
                                    toggleSpeech()
                                } label: {
                                    Image(systemName: isSpeaking ? "pause.fill" : "play.fill")
                                        .foregroundColor(.blackBtnText)
                                        .frame(width: 50, height: 50)
                                }
                                .background(Color.onboardingDarkGreen)
                                .cornerRadius(30)
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "forward.fill")
                                        .foregroundColor(.onboardingGray)
                                        .frame(width: 25, height: 20)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            
                            // select speed button
                            Button {
                                if speechSynthesizer.isSpeaking {
                                    speechSynthesizer.pauseSpeaking(at: .immediate)
                                    isSpeaking = false
                                    stopTimer()
                                }
                                isSpeedViewShowing = true
                            } label: {
                                VStack(spacing: 0) {
                                    Text(selectedVoiceSpeed)
                                        .foregroundColor(.onboardingDarkGreen)
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                    
                                    Text("Speed")
                                        .foregroundColor(.blackBtn)
                                        .font(.system(size: 10))
                                        .fontWeight(.regular)
                                }
                                .frame(width: 70, height: 40)
                                .background(.onboardingCardGrey)
                                .cornerRadius(15)
                            }
                            .frame(alignment: .trailing)
                            .sheet(isPresented: $isSpeedViewShowing) {
                                SelectSpeedView(selectedVoiceSpeed: $selectedVoiceSpeed)
                                    .presentationDetents([.height(470)])
                                    .presentationDragIndicator(.visible)
                                    .cornerRadius(20)
                            }
                            
                        }
                        .padding()
                        
                    }
                    .padding([.leading, .trailing, .top], 10)
                    .padding(.bottom, 0)
                }
                .blur(radius: isAddNotesViewShowing ? 5 : 0)
                .blur(radius: isAvatarViewShowing ? 5 : 0)
                .blur(radius: isSpeedViewShowing ? 5 : 0)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension PdfView {
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
                    print("Debug: Current progress - Elapsed: \(formatTime(self.elapsedTime)), Total: \(formatTime(self.totalTime)), Progress: \(self.progress)")
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
    PdfView()
        .environmentObject(TabBarVisibility())
}
