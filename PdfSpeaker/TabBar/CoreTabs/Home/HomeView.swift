//
//  HomeView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct HomeView: View {
    let userName = UserDefaults.standard.string(forKey: "userName") ?? "John"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Top Bar
            HStack {
                Text("Ai PDF Speaker")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    
                Spacer()
                
                Button {
                    
                } label: {
                    Image("premiumCrown")
                        .frame(width: 30, height: 25)
                    
                }

            }
            .padding()
            
            
            Spacer()
            
            // Name and hello label
            VStack(alignment: .leading, spacing: 5) {
                Text("Hello \(userName)👋")
                    .foregroundColor(.onboardingGray)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                
                Text("What do you want to listen?")
                    .foregroundColor(.blackBtn)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
            }
            .padding()
            
            
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading ,spacing: 10) {
                                Image("pdf&More")
                                    .frame(width: 25, height: 30, alignment: .leading)
                                
                                Text("PDF & More")
                                    .foregroundColor(.blackBtn)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Seamlessly convert PDF’s\n and other file types")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 15)
                        }
                        .frame(width: geometry.size.width * 0.6, height: 160)
                        .background(.onboardingCardGrey)
                        .cornerRadius(25)
                        
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading ,spacing: 10) {
                                Image("scanText")
                                    .frame(width: 25, height: 30, alignment: .leading)
                                
                                Text("Scan Text")
                                    .foregroundColor(.blackBtn)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Scanned Docs or\nImages")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 15)
                        }
                        .frame(width: geometry.size.width * 0.4, height: 160)
                        .background(.onboardingCardGrey)
                        .cornerRadius(25)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                }
                .padding(.horizontal)
                .frame(height: 160)
                
                GeometryReader { geometry in
                    HStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading ,spacing: 10) {
                                Image("webLink")
                                    .frame(width: 25, height: 30, alignment: .leading)
                                
                                Text("Web Link")
                                    .foregroundColor(.blackBtn)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Transform URL’s\ninto audio")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 15)
                        }
                        .frame(width: geometry.size.width * 0.4, height: 160)
                        .background(.onboardingCardGrey)
                        .cornerRadius(25)
                        
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading ,spacing: 10) {
                                Image("typeOrPasteText")
                                    .frame(width: 25, height: 30, alignment: .leading)
                                
                                Text("Type or Paste Text")
                                    .foregroundColor(.blackBtn)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Simply enter or paste\nyour text and listen")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.leading, 15)
                        }
                        .frame(width: geometry.size.width * 0.6, height: 160)
                        .background(.onboardingCardGrey)
                        .cornerRadius(25)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding()
                }
                .padding(.horizontal)
                .frame(height: 160)
            }
            
            
            
            Spacer()
        }
    }
}


#Preview {
    HomeView()
}
