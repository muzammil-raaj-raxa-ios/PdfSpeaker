//
//  TabBarView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    @EnvironmentObject var tabBarVisibility: TabBarVisibility
    
    let tabs: [TabBarTabsModel] = [
        TabBarTabsModel(tabImage: "text.page", selectedTabImage: "text.page.fill", tabTitle: "Library"),
        TabBarTabsModel(tabImage: "house", selectedTabImage: "house.fill", tabTitle: "Home"),
        TabBarTabsModel(tabImage: "gearshape", selectedTabImage: "gearshape.fill", tabTitle: "Settings")
    ]
    
    var body: some View {
        
        VStack {
            
            switch selectedTab {
            case 0:
                LibraryView()
            case 1:
                HomeView()
            case 2:
                SettingsView()
            default:
                HomeView()
            }
            
            Spacer()
            
            
            if !tabBarVisibility.hideTabBar {
                HStack(alignment: .center, spacing: 60) {
                    
                    ForEach(0..<3, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack {
                                Image(systemName: selectedTab == tab ? tabs[tab].selectedTabImage : tabs[tab].tabImage)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(selectedTab == tab ? .blackBtn : .onboardingGray)
                                
                                Text(tabs[tab].tabTitle)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                                    .foregroundColor(selectedTab == tab ? .blackBtn : .onboardingGray)
                            }
                        }
                    }
                    
                    
                }
                .frame(width: 300, height: 60)
                .background(Color.avatarBG)
                .cornerRadius(30)
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    TabBarView()
        .environmentObject(TabBarVisibility())
}
