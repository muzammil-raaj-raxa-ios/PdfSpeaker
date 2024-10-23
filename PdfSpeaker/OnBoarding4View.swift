//
//  OnBoarding4.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI

struct OnBoarding4View: View {
    @State private var selectedGender: GenderModel?
    @State private var isNavigationTrue = false
    @State private var showAlert = false
    
    let genders: [GenderModel] = [
        GenderModel(name: "🧔🏻‍♂️  Male"),
        GenderModel(name: "👩  Female"),
        GenderModel(name: "⚧️️  Others"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(index == 0 ? Color.onboardingDarkGreen : (index == 1 || index == 2 || index == 3 ? Color.onboardingDarkGreen : Color.onboardingLightGreen))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 50)
                .padding([.bottom, .top], 20)
                
                VStack(spacing: 10) {
                    Text("Select your Gender👫")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Choose One:")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.onboardingGray)
                }
                
                List(genders) { gender in
                    HStack {
                        Text(gender.name)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                    }
                    .listRowBackground(Color.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(selectedGender == gender ? Color.onboardingLightGreen : Color.clear)
                    .border(selectedGender == gender ? Color.onboardingLightGreen : Color.clear, width: 1)
                    .cornerRadius(25)
                    .onTapGesture {
                        selectedGender = gender
                    }
                }
                .scrollContentBackground(.hidden)
                
                NavigationLink(destination: OnBoarding5View(), isActive: $isNavigationTrue) {
                    EmptyView()
                }
                .hidden()
                
                Button {
                    if selectedGender == nil {
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
                .padding(.bottom, 0)
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("PDF Speaker"),
                        message: Text("Please select a gender."),
                        dismissButton: .default(Text(("Ok")))
                    )
                }
                
                Spacer()
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoarding4View()
}
