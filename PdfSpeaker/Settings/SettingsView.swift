//
//  SettingsView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct SettingsView: View {
    
    let settings: [SettingModel] = [
        SettingModel(image: UIImage(named: "changeVoice")!, name: "Change Voice", more: "Emily"),
        SettingModel(image: UIImage(named: "voiceSpeed")!, name: "Voice Speed", more: "1.5x"),
        SettingModel(image: UIImage(named: "appTheme")!, name: "App Theme", more: "Light"),
        SettingModel(image: UIImage(named: "feedback")!, name: "Feedback", more: ""),
        SettingModel(image: UIImage(named: "restorePurchase")!, name: "Restore Purchase", more: ""),
        SettingModel(image: UIImage(named: "privacyPolicy")!, name: "Privacy Policy", more: ""),
        SettingModel(image: UIImage(named: "termsOfService")!, name: "Terms of Service", more: ""),
        SettingModel(image: UIImage(named: "communityGuidelines")!, name: "Community Guidelines", more: ""),
    ]
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
                // premium Button
                Button {
                    
                } label: {
                    Image("diamond")
                        .frame(width: 20, height: 20)
                        .padding(.leading, 20)
                    
                    Text("Get Premium")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.onboardingDarkGreen)
                        .frame(maxWidth: .infinity, maxHeight: 50 , alignment: .leading)
                }
                .background(Color.onboardingLightGreen)
                .cornerRadius(30)
                .padding(.horizontal)
            

                List {
                    ForEach(settings.prefix(3).indices, id: \.self) { index in
                        NavigationLink(destination: Text("Value")) {
                            HStack {
                                Image(uiImage: settings[index].image)
                                    .frame(width: 20, height: 20)
                                
                                Text(settings[index].name)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Text(settings[index].more)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                            }
                            .frame(height: 50)
                            .padding(.trailing, 0)
                        }
                        .padding(.horizontal)
                        .listRowBackground(Color.clear)
                        .background(Color.onboardingCardGrey)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .frame(height: 150)
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .cornerRadius(25)
                .padding(.horizontal)
                .padding(.top, 20)
                .navigationBarHidden(true)
            
            
                List {
                    ForEach(settings.dropFirst(3).indices, id: \.self) { index in
                        NavigationLink(destination: Text("Value")) {
                            HStack {
                                Image(uiImage: settings[index].image)
                                    .frame(width: 20, height: 20)
                                
                                Text(settings[index].name)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                            }
                            .frame(height: 50)
                            .padding(.trailing, 0)
                        }
                        .padding(.horizontal)
                        .listRowBackground(Color.clear)
                        .background(Color.onboardingCardGrey)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .frame(height: 250)
                .listStyle(PlainListStyle())
                .background(.clear)
                .cornerRadius(25)
                .padding(.horizontal)
                .padding(.top, 20)
                .navigationBarHidden(true)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
