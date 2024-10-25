//
//  SelectSpeedView.swift
//  PdfSpeaker
//
//  Created by raaj on 25/10/2024.
//

import SwiftUI

struct SelectSpeedView: View {
    @State private var voiceSpeed: Float = 1.0
    
    var body: some View {
        VStack {
            Text("Select an AI Enhancer Voice")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .padding()
                .padding(.top, 20)
            
            Text("Normal")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .padding(.bottom, 10)
            
            Text("30% productivity boost")
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
            
            Text("250 words per minutes")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 12))
                .fontWeight(.regular)
                .padding(.top, 30)
            
            SpeechWaveView()
                .frame(height: 50)
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
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.avatarBG)
    }
}

extension SelectSpeedView {
    func inceaseSpeed() {
        voiceSpeed = min(voiceSpeed + 0.1, 2.0)
    }
    
    func decreaseSpeed() {
        voiceSpeed = max(voiceSpeed - 0.1, 0.5)
    }
}

#Preview {
    SelectSpeedView()
}
