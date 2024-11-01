//
//  TabBarView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    @State private var isPlaying: Bool = false
    
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
                if isPlaying {
                    HStack {
                        Image("bottomPlayerImg")
                            .frame(width: 30, height: 40)
                            .padding(.leading, 25)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Speaker_file.pdf")
                                .foregroundColor(.blackBtn)
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ProgressView(value: 0.7)
                                .tint(.onboardingDarkGreen)
                                .background(Color.onboardingLightGreen)
                                .padding(.horizontal, 1)
                                .frame(width: 140)
                        }
                        .padding(.leading, 15)
                        
                        
                        
                        Button {
                            isPlaying.toggle()
                        } label: {
                            Image(systemName: isPlaying ? "play.circle" : "pause.circle")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.onboardingDarkGreen)
                                .padding(.trailing, 10)
                        }
                        
                        
                        
                        Spacer()
                    }
                    .frame(width: 300 ,height: 60)
                    .background(.onboardingLightGreen)
                    .cornerRadius(20)
                    .padding(.bottom, 0)
                }
                
                
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
        .background(.clear)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    TabBarView()
        .environmentObject(TabBarVisibility())
}
