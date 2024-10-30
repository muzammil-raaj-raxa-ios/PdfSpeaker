//
//  FeedbackButton.swift
//  PdfSpeaker
//
//  Created by r a a j on 30/10/2024.
//

import SwiftUI

struct FeedbackButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .blackBtnText : .onboardingGray)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .padding()
                .frame(width: 170, height: 50)
                .background(isSelected ? .blackBtn : .onboardingCardGrey)
                .cornerRadius(25)
        }
    }
}

#Preview {
//    FeedbackButton()
}
