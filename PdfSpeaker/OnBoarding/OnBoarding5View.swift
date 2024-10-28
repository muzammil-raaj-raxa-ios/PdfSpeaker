//
//  OnBoarding5View.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 23/10/2024.
//

import SwiftUI

struct OnBoarding5View: View {
    @State private var selectedAge: AgeModel?
    @State private var isNavigationTrue = false
    @State private var showAlert = false
    
    let ages: [AgeModel] = [
        AgeModel(age: "Under 20s"),
        AgeModel(age: "20-30s"),
        AgeModel(age: "30-40s"),
        AgeModel(age: "41-50s"),
        AgeModel(age: "51-60s"),
        AgeModel(age: "70s or above"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(index == 0 ? Color.onboardingDarkGreen : (index == 1 || index == 2 || index == 3 || index == 4 ? Color.onboardingDarkGreen : Color.onboardingLightGreen))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 50)
                .padding([.bottom, .top], 20)
                
                VStack(spacing: 10) {
                    Text("What’s your Age🗓️")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                    
                    Text("Choose One:")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.onboardingGray)
                }
                
                
                // Age list
                if #available(iOS 16.0, *) {
                    List(ages) { age in
                        HStack {
                            Text(age.age)
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color.blackBtn)
                                .padding(.leading, 15)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedAge == age ? Color.onboardingLightGreen : Color.onboardingCardGrey)
                        .border(selectedAge == age ? Color.onboardingLightGreen : Color.onboardingCardGrey, width: 1)
                        .cornerRadius(25)
                        .onTapGesture {
                            selectedAge = age
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                
                NavigationLink(destination: OnBoarding6View(), isActive: $isNavigationTrue) {
                    EmptyView()
                }
                .hidden()
                
                
                // Next Button
                Button {
                    if selectedAge == nil {
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnBoarding5View()
}
