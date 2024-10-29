//
//  SettingsView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedView: String? = nil
    @State private var selectedSheetView: SettingSheet? = nil
    @State private var avatarImage: UIImage = UIImage(named: "avatar1")!
    @State private var selectVoiceViewShowing: Bool = false
    
    let settingSectionOne: [SectionOneSettingModel] = [
        SectionOneSettingModel(image: UIImage(named: "changeVoice")!, name: "Change Voice", more: "Emily"),
        SectionOneSettingModel(image: UIImage(named: "voiceSpeed")!, name: "Voice Speed", more: "1.5x"),
        SectionOneSettingModel(image: UIImage(named: "appTheme")!, name: "App Theme", more: "Light")
    ]
    
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
                        .padding()
                    
                    
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
                                        selectedSheetView = destinationSheetView(for: sectionOne.name)
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
                                    .sheet(item: $selectedSheetView) { item in
                                        destinationSheetContent(for: item)
                                            .presentationDragIndicator(.visible)
                                            .cornerRadius(20)
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
            }
        }
    }
    
    
    private func destinationSheetView(for name: String) -> SettingSheet? {
        if #available(iOS 16.0, *) {
            switch name {
            case "Change Voice":
                return .changeVoice
            case "Voice Speed":
                return .voiceSpeed
            case "App Theme":
                return .appTheme
            default:
                return nil
            }
        }
        return nil
    }
    
    @ViewBuilder
    private func destinationSheetContent(for sheet: SettingSheet) -> some View {
        if #available(iOS 16.0, *) {
            switch sheet {
            case .changeVoice:
                SelectVoiceView(selectedAvatarImage: $avatarImage)
                    .presentationDetents([.height(450)])
                
            case .voiceSpeed:
                SelectSpeedView()
                    .presentationDetents([.height(470)])
            case .appTheme:
                AppThemeView()
                    .presentationDetents([.height(350)])
            }
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
