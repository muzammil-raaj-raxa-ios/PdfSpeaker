//
//  AppThemeView.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import SwiftUI

struct AppThemeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTheme: ThemeType = loadTheme()
    
    @Binding var selectedThemeName: String
    @Environment(\.dismiss) private var dismiss
    
    let themes: [AppThemeModel] = [
        AppThemeModel(name: "System default", image: "iphone", type: .system),
        AppThemeModel(name: "Light", image: "sun.min", type: .light),
        AppThemeModel(name: "Dark", image: "moon.stars", type: .dark),
    ]
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                List(themes) { theme in
                    HStack {
                        Image(systemName: theme.image)
                            .frame(width: 20, height: 20)
                            .padding(.leading, 30)
                            .foregroundColor(selectedTheme == theme.type ? Color.onboardingDarkGreen : .onboardingGray)
                        
                        Text(theme.name)
                            .foregroundColor(selectedTheme == theme.type ? Color.onboardingDarkGreen : .onboardingGray)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .padding(.leading, 10)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(selectedTheme == theme.type ? Color.onboardingLightGreen : .blackBtnText)
                    .border(selectedTheme == theme.type ? Color.onboardingLightGreen : .blackBtnText, width: 1)
                    .cornerRadius(25)
                    .onTapGesture {
                        selectedTheme = theme.type
                        selectedThemeName = theme.name
                        themeManager.applyTheme(selectedTheme)
                    }
                }
                .scrollContentBackground(.hidden)
                
                
                // Button styling
                Button {
                    dismiss()
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
            .frame(maxWidth: .infinity)
            .background(.avatarBG)
            .preferredColorScheme(
                selectedTheme == .light ? .light : selectedTheme == .dark ? .dark : nil
            )
            .presentationDetents([.height(350)])
        }
    }
    
    public static func loadTheme() -> ThemeType {
        let theme = UserDefaults.standard.string(forKey: "selectedTheme") ?? ThemeType.system.rawValue
        return ThemeType(rawValue: theme) ?? .system
    }
}

#Preview {
    @State var theme = "Light"
    return AppThemeView(selectedThemeName: $theme)
}
