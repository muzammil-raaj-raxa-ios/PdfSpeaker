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
                        .foregroundColor(.black)
                    
                    Text("Enter your name:")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.onboardingGray)
                }
                
                TextField("Enter your name", text: $name)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .padding(.leading, 40)
                    .padding(.top, 20)
                    .background(Color.white)
                
                Spacer()
                
                NavigationLink(destination: OnBoarding4View(), isActive: $isNavigationTrue) {
                    EmptyView()
                }
                .hidden()
                
                Button {
                    if name.isEmpty {
                        showAlert = true
                    } else {
                        isNavigationTrue = true
                    }
                } label: {
                    Text("Next")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .background(Color.blackBtn)
                .cornerRadius(30)
                .padding(.bottom, 20)
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("PDF Speaker"),
                        message: Text("Please select a profession."),
                        dismissButton: .default(Text(("Ok")))
                    )
                }
                
                
            }
            .background(.white)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoarding3View()
}
