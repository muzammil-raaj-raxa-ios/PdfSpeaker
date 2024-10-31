//
//  CategoryButtonView.swift
//  PdfSpeaker
//
//  Created by r a a j on 31/10/2024.
//

import SwiftUI

struct CategoryButtonView: View {
    @State private var selectedButton: String = "All"
    
    let buttons = ["All", "Contined", "Listened"]
    
    var body: some View {
        // Content view
        VStack {
            
            GeometryReader { geometry in
                // category buttons
                HStack {
                    HStack {
                        
                        ForEach(buttons, id: \.self) { button in
                            Button {
                                withAnimation {
                                    selectedButton = button
                                }
                            } label: {
                                Text(button)
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedButton == button ? .blackBtnText : .onboardingGray)
                                    .frame(width: (geometry.size.width * 0.75) / 3, height: 40)
                                    .background(selectedButton == button ? .blackBtn : .onboardingCardGrey)
                                    .cornerRadius(20)
                            }
                        }
                        
                    }
                    .frame(width: geometry.size.width * 0.75, height: 40, alignment: .center)
                    .background(.onboardingCardGrey)
                    .cornerRadius(20)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 40)
        }
        
    }
}

#Preview {
    CategoryButtonView()
}
