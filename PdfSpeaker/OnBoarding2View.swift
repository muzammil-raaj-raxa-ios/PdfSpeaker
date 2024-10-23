//
//  OnBoarding2View.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI

struct OnBoarding2View: View {
    @State private var isNavigationTrue = false
    @State private var selectedProfession: ProfessionModel?
    @State private var showAlert = false
    
    let professions: [ProfessionModel] = [
        ProfessionModel(name: "📚  Student & Educator"),
        ProfessionModel(name: "💼  Business, Tech & Creative"),
        ProfessionModel(name: "👩🏻‍⚕️  Health & Wellness"),
        ProfessionModel(name: "🏛️  Law & Government"),
        ProfessionModel(name: "👨🏻‍🎨  Entrepreneurs & Executives"),
        ProfessionModel(name: "🕵  Others"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(index == 0 ? Color.onboardingDarkGreen : (index == 1 ? Color.onboardingDarkGreen : Color.onboardingLightGreen))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 50)
                .padding([.bottom, .top], 20)
                
                
                VStack(spacing: 10) {
                    Text("What’s your Profession🤗")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Choose one:")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.onboardingGray)
                }
                
                List(professions) { profession in
                    HStack {
                        Text(profession.name)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                    }
                    .listRowBackground(Color.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(selectedProfession == profession ? Color.onboardingLightGreen : Color.clear)
                    .border(selectedProfession == profession ? Color.onboardingLightGreen : Color.clear, width: 1)
                    .cornerRadius(25)
                    .onTapGesture {
                        selectedProfession = profession
                    }
                }
                .scrollContentBackground(.hidden)
                
                NavigationLink(destination: OnBoarding3View(), isActive: $isNavigationTrue) {
                    EmptyView()
                }
                .hidden()
                
                Button {
                    if selectedProfession == nil {
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
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("PDF Speaker"),
                        message: Text("Please select a profession."),
                        dismissButton: .default(Text(("Ok")))
                    )
                }
                
                Spacer()
                
            }
            .background(.white)
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoarding2View()
}
