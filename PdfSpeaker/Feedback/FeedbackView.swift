//
//  FeedbackView.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import SwiftUI

struct FeedbackView: View {
    @State private var isTopViewVisible: Bool = true
    @State private var selectedOption: String = "Crashes"
    @State private var selectedButton: Int = 1
    @State private var text: String = ""
    @State private var selectedTheme: ThemeType = loadTheme()
    @FocusState private var isFocusedTextEditor: Bool
        
    
    @Environment(\.presentationMode) var popView: Binding<PresentationMode>
    
    let placeholder = "Enter Text Here"
    let options = [
        ["Crashes", "Page not Loading"],
        ["App not Responding", "Function disable"],
        ["Multiple ads", "Premium not working"],
        ["Don't know how to use", "Others"]
    ]
    
    var issuePlaceholderText: String {
            """
            Describe the issue you’ve encountered here.
            
            1. On what page have you encountered the issue?
            2. After what action that you performed did the issue appear in app?
            3. Give us the additional information that might help us to fix the issue you are facing.
            """
    }
    
    var suggestionPlaceholderText: String {
            """
            Tell us how can we improve our app?
            """
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
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
                            
                            Text("Feedback")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        // popup view button
                        if isTopViewVisible {
                            HStack {
                                Button {
                                    withAnimation {
                                        isTopViewVisible.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Report bugs every time you encounter problems\nto help us solve them faster.")
                                            .foregroundColor(.onboardingDarkGreen)
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .padding(.leading, 15)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "xmark")
                                            .foregroundColor(.onboardingDarkGreen)
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing, 15)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 60)
                                    .background(.onboardingLightGreen)
                                    .cornerRadius(25)
                                    .padding()
                                }
                                
                                Spacer()
                            }
                        }
                        
                        // segmented buttons
                        HStack {
                            // issue button
                            Button {
                                withAnimation {
                                    selectedButton = 1
                                }
                            } label: {
                                HStack {
                                    Image(systemName: selectedButton == 1 ? "circle.circle.fill" : "circle")
                                        .foregroundColor(selectedButton == 1 ? .blackBtnText : .onboardingGray)
                                        .frame(width: 20, height: 20)
                                        .padding(.leading, 15)
                                    
                                    Spacer()
                                    
                                    Text("Issues")
                                        .foregroundColor(selectedButton == 1 ? .blackBtnText : .onboardingGray)
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .padding(.trailing, 40)
                                }
                                .cornerRadius(25)
                                .frame(width: 170, height: 50)
                                .background(selectedButton == 1 ? .blackBtn : .onboardingCardGrey)
                            }
                            .cornerRadius(25)
                            
                            // suggestion button
                            Button {
                                withAnimation {
                                    selectedButton = 2
                                }
                            } label: {
                                HStack {
                                    Image(systemName: selectedButton == 2 ? "circle.circle.fill" : "circle")
                                        .foregroundColor(selectedButton == 2 ? .blackBtnText : .onboardingGray)
                                        .frame(width: 20, height: 20)
                                        .padding(.leading, 15)
                                    
                                    Spacer()
                                    
                                    Text("Suggestions")
                                        .foregroundColor(selectedButton == 2 ? .blackBtnText : .onboardingGray)
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .padding(.trailing, 15)
                                }
                                .cornerRadius(25)
                                .frame(width: 170, height: 50)
                                .background(selectedButton == 2 ? .blackBtn : .onboardingCardGrey)
                            }
                            .cornerRadius(25)
                            
                        }
                        .padding(.top, 10)
                        
                        
                        // Text view
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $text)
                                .colorMultiply(.onboardingCardGrey)
                                .foregroundColor(selectedTheme.rawValue == "dark" ? .white : .blackBtn)
                                .frame(height: 150)
                                .cornerRadius(25)
                                .padding()
                                .focused($isFocusedTextEditor)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                            
                            if text.isEmpty {
                                Text(selectedButton == 1 ? issuePlaceholderText : suggestionPlaceholderText)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(.onboardingGray)
                                    .padding([.top, .leading], 30)
                                    .padding(.trailing, 10)
                            }
                            
                        }
                        
                        HStack {
                            Text("Select Item")
                                .foregroundColor(.onboardingGray)
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .padding(.leading, 20)
                                .padding(.bottom, 10)
                            
                            Spacer()
                        }
                        
                        
                        // 4x2 buttons
                        VStack(spacing: 20) {
                            ForEach(options, id: \.self) { row in
                                HStack {
                                    ForEach(row, id: \.self) { option in
                                        FeedbackButton(
                                            title: option,
                                            isSelected: selectedOption == option
                                        ) {
                                            selectedOption = option
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                
                Button {
                    text = ""
                    isFocusedTextEditor = false
                } label: {
                    Text("Submit")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.blackBtnText)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }
                .background(Color.blackBtn)
                .cornerRadius(30)
                .padding()
                .padding(.bottom, 0)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
    public static func loadTheme() -> ThemeType {
        let theme = UserDefaults.standard.string(forKey: "selectedTheme") ?? ThemeType.system.rawValue
        return ThemeType(rawValue: theme) ?? .system
    }
}

#Preview {
    FeedbackView()
}
