//
//  NavBarView.swift
//  PdfSpeaker
//
//  Created by r a a j on 31/10/2024.
//

import SwiftUI

struct NavBarView: View {
    
    @State private var isSearchBarShowing: Bool = false
    @State private var isNavBarShowing: Bool = true
    @Binding var searchText: String
    @FocusState private var isFocusedSearchBar: Bool
    
    
    var body: some View {
        
        // top bar
        ZStack {
            
            // top bar with Title
            if isNavBarShowing {
                HStack {
                    Text("My Library")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "star.circle")
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.onboardingDarkGreen)
                                
                                Text("5")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.onboardingDarkGreen)
                            }
                            .frame(width: 50, height: 25)
                            .background(.onboardingLightGreen)
                            .cornerRadius(10)
                            .padding(.trailing, 5)
                        }
                        
                        
                        Button {
                            isSearchBarShowing.toggle()
                            isNavBarShowing = false
                            isFocusedSearchBar = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .frame(width: 25, height: 25)
                                .foregroundColor(.onboardingGray)
                        }
                        
                        
                    }
                }
            }
            
            
            if isSearchBarShowing {
                HStack {
                    GeometryReader { geometry in
                        HStack {
                            // search bar
                            HStack {
                                ZStack(alignment: .leading) {
                                    if searchText.isEmpty {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.onboardingGray)
                                                .padding(.leading, 15)
                                            
                                            Text("Search")
                                                .foregroundColor(.onboardingGray)
                                                .font(.system(size: 15))
                                                .fontWeight(.regular)
                                                .padding(.leading, 2)
                                        }
                                    }
                                    
                                    if #available(iOS 16.0, *) {
                                        TextField("", text: $searchText)
                                            .foregroundColor(.blackBtn)
                                            .tint(.onboardingGray)
                                            .font(.system(size: 15))
                                            .fontWeight(.regular)
                                            .padding(.horizontal, 15)
                                            .focused($isFocusedSearchBar)
                                    }
                                }
                                
                                
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.8, height: 30)
                            .background(.onboardingCardGrey)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.onboardingLightGreen, lineWidth: 1)
                            )
                            
                            
                            
                            
                            Spacer()
                            
                            
                            // cancel button
                            Button {
                                isNavBarShowing.toggle()
                                isSearchBarShowing = false
                                isFocusedSearchBar = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .padding(.trailing, 10)
                            }
                            
                            
                            
                            
                        }
                    }
                }
                .frame(height: 30)
            }
            
        }
        .padding()
    }
}

#Preview {
//    NavBarView()
}
