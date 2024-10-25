//
//  ContentView.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI

struct OnBoarding1View: View {
    @State private var isNavigationTrue = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("onboarding")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.6)
                }
                .overlay(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1.0), Color.white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 160)
                        
                        Spacer()
                        
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.0), Color.white.opacity(1.0)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 160)
                    }
                        .frame(maxHeight: 600)
                )
                .frame(maxHeight: .infinity, alignment: .top)
                
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(index == 0 ? Color.onboardingDarkGreen : Color.onboardingLightGreen)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom, UIScreen.main.bounds.height < 700 ? 600 : 700)
                
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Image("onboardingStars")
                    
                    VStack(spacing: 5) {
                        Text("Welcome")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.blackBtn) +
                        
                        Text(" to PDF")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blackBtn) +
                        
                        Text(" Speaker")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blackBtn)
                        
                        Text("Read anything aloud in the highest\nquality voices.")
                            .font(.system(size: 16))
                            .foregroundColor(Color.onboardingGray)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: OnBoarding2View(), isActive: $isNavigationTrue) {
                        EmptyView()
                    }
                    .hidden()
                    
                        Button {
                            isNavigationTrue = true
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
                    
                }
            }
//            .background(Color.white)
        }
    }
}


#Preview {
    OnBoarding1View()
}
