//
//  OnBoarding3View.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI

struct OnBoarding3View: View {
    @State private var name: String = ""
    @State private var isNavigationTrue = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(index == 0 ? Color.onboardingDarkGreen : (index == 1 || index == 2 ? Color.onboardingDarkGreen : Color.onboardingLightGreen))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 50)
                .padding([.bottom, .top], 20)
                
                VStack(spacing: 10) {
                    Text("What’s your Name🥰")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                    
                    Text("Enter your name:")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.onboardingGray)
                }
                .padding(.bottom, 20)
                
                
                // Name textfield
                if #available(iOS 16.0, *) {
                    TextField("Enter your name", text: $name)
                        .font(.system(size: 14))
                        .tint(.blackBtn)
                        .fontWeight(.medium)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.onboardingLightGreen, lineWidth: 2)
                        )
                        .padding()
                        .onChange(of: name) { newValue in
                            if newValue.count > 30 {
                                name = String(newValue.prefix(30))
                            }
                        }
                } 
                
                Spacer()
                
                NavigationLink(destination: OnBoarding4View(), isActive: $isNavigationTrue) {
                    EmptyView()
                }
                .hidden()
                
                
                // Next button
                Button {
                    if name.trimmingCharacters(in: .whitespaces).count < 3 {
                        showAlert = true
                    } else {
                        isNavigationTrue = true
                    }
                } label: {
                    Text("Next")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.blackBtnText)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .background(Color.blackBtn)
                .cornerRadius(30)
                .padding(.bottom, 20)
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("PDF Speaker"),
                        message: Text("Please provide a valid name."),
                        dismissButton: .default(Text(("Ok")))
                    )
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoarding3View()
}
