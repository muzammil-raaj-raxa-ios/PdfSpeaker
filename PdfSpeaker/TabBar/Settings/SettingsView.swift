//
//  SettingsView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedView: String? = nil
    //    @State private var selectedSheetView: Bool = false
    @State private var showSpeedSheet: Bool = false
    @State private var showThemeSheet: Bool = false
    @State private var showVoiceSheet: Bool = false
    @State private var avatarImage: UIImage = UIImage(named: "avatar1")!
    @State private var selectVoiceViewShowing: Bool = false
    @State private var selectedVoice: String = "Emily"
    @State private var selectedVoiceSpeed: String = "1.0 x"
    @State private var selectedAppTheme: String = "Light"
    
    private var settingSectionOne: [SectionOneSettingModel] {
        [
            SectionOneSettingModel(image: UIImage(named: "changeVoice")!, name: "Change Voice", more: selectedVoice),
            SectionOneSettingModel(image: UIImage(named: "voiceSpeed")!, name: "Voice Speed", more: selectedVoiceSpeed),
            SectionOneSettingModel(image: UIImage(named: "appTheme")!, name: "App Theme", more: selectedAppTheme)
        ]
    }
    
    let settingSectionTwo: [SectionTwoSettingModel] = [
        SectionTwoSettingModel(image: UIImage(named: "feedback")!, name: "Feedback"),
        SectionTwoSettingModel(image: UIImage(named: "restorePurchase")!, name: "Restore Purchase"),
        SectionTwoSettingModel(image: UIImage(named: "privacyPolicy")!, name: "Privacy Policy"),
        SectionTwoSettingModel(image: UIImage(named: "termsOfService")!, name: "Terms of Service"),
        SectionTwoSettingModel(image: UIImage(named: "communityGuidelines")!, name: "Community Guidelines"),
    ]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    Text("Settings")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    // premium Button
                    Button {
                        selectedView = "Premium"
                    } label: {
                        HStack {
                            Image("diamond")
                                .frame(width: 20, height: 20)
                                .padding(.leading, 20)
                            
                            Text("Get Premium")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.onboardingDarkGreen)
                                .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                    }
                    .background(Color.onboardingLightGreen)
                    .cornerRadius(30)
                    .padding(.horizontal)
                    .background(
                        NavigationLink("", destination: PremiumView(), tag: "Premium", selection: $selectedView)
                            .hidden()
                    )
                    
                    
                    VStack(spacing: 0) {
                        // First List
                        List {
                            ForEach(settingSectionOne, id: \.self) { sectionOne in
                                Button {
                                    handleSettingTap(sectionOne.name)
                                } label: {
                                    HStack {
                                        Image(uiImage: sectionOne.image)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(sectionOne.name)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.onboardingGray)
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 0) {
                                            Text(sectionOne.more)
                                                .font(.system(size: 12))
                                                .fontWeight(.regular)
                                                .foregroundColor(.onboardingGray)
                                            
                                            Image("goTo")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                                                                
                            }
                            .listRowBackground(Color.onboardingCardGrey)
                        }
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
                        .frame(height: 170)
                        
                        
                        // Second List
                        List {
                            ForEach(settingSectionTwo, id: \.self) { sectionTwo in
                                Button {
                                    selectedView = sectionTwo.name
                                } label: {
                                    HStack {
                                        Image(uiImage: sectionTwo.image)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(sectionTwo.name)
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(.onboardingGray)
                                        
                                        Spacer()
                                        
                                        Image("goTo")
                                            .frame(width: 20, height: 20)
                                        
                                    }
                                }
                                .background(
                                    NavigationLink("", destination: destinationView(for: sectionTwo.name), tag: sectionTwo.name, selection: $selectedView)
                                        .hidden()
                                )
                            }
                            .listRowBackground(Color.onboardingCardGrey)
                        }
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
                        .frame(height: 270)
                        
                    }
                    
                    Spacer()
                }
                .sheet(isPresented: $showVoiceSheet) {
                    SelectVoiceView(selectedAvatarName: $selectedVoice, selectedAvatarImage: $avatarImage)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(450)])
                }
                .sheet(isPresented: $showSpeedSheet) {
                    SelectSpeedView(selectedVoiceSpeed: $selectedVoiceSpeed)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(470)])
                }
                .sheet(isPresented: $showThemeSheet) {
                    AppThemeView(selectedThemeName: $selectedAppTheme)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(350)])
                }

            }
        }
    }
    
    private func handleSettingTap(_ name: String) {
        switch name {
        case "Change Voice":
            showVoiceSheet = true
        case "Voice Speed":
            showSpeedSheet = true
        case "App Theme":
            showThemeSheet = true
        default:
            break
        }
    }
    
    @ViewBuilder
    private func destinationView(for name: String) -> some View {
        switch name {
        case "Premium":
            PremiumView()
        case "Feedback":
            FeedbackView()
        case "Restore Purchase":
            FeedbackView()
        case "Privacy Policy":
            FeedbackView()
        case "Terms of Service":
            FeedbackView()
        case "Community Guidelines":
            FeedbackView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    SettingsView()
}
