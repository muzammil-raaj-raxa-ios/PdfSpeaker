//
//  SelectAvatarView.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 25/10/2024.
//

import SwiftUI

struct SelectAvatarView: View {
    @State private var selectedAvatarName: String = "Kathrine"
    @Binding var selectedAvatarImage: UIImage
    @Environment(\.dismiss) private var dismiss
    
    let avatars: [AvatarModel] = [
        AvatarModel(image: UIImage(named: "avatar1")!, name: "Kathrine", description: "Hollywood Actress"),
        AvatarModel(image: UIImage(named: "avatar2")!, name: "Emily", description: "Youtuber"),
        AvatarModel(image: UIImage(named: "avatar3")!, name: "Elizabeth", description: "American Rapper"),
        AvatarModel(image: UIImage(named: "avatar4")!, name: "Grace", description: "Hollywood Actress"),
        AvatarModel(image: UIImage(named: "avatar1")!, name: "Maeve", description: "Youtuber"),
        AvatarModel(image: UIImage(named: "avatar4")!, name: "Gina", description: "American Rapper"),
    ]
    
    var body: some View {
        VStack {
            Text("Select an AI Enhancer Voice")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .padding()
                .padding(.top, 20)
            
            // 2x3 grid layout button
            VStack(spacing: 25) {
                HStack(spacing: 25) {
                    ForEach(0..<3, id: \.self) { index in
                        Button {
                            selectedAvatarName = avatars[index].name
                            selectedAvatarImage = avatars[index].image
                        } label: {
                            VStack {
                                Image(uiImage: avatars[index].image)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .fill(selectedAvatarName == avatars[index].name ? .onboardingLightGreen : Color.blackBtnText)
                                    )
                                
                                Text(avatars[index].name)
                                    .foregroundColor(Color.primary)
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                
                                Text(avatars[index].description)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                            }
                            
                        }
                        
                    }
                }
                
                HStack(spacing: 25) {
                    ForEach(3..<6, id: \.self) { index in
                        Button {
                            selectedAvatarName = avatars[index].name
                            selectedAvatarImage = avatars[index].image
                        } label: {
                            VStack {
                                Image(uiImage: avatars[index].image)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .fill(selectedAvatarName == avatars[index].name ? .onboardingLightGreen : Color.blackBtnText)
                                    )
                                
                                Text(avatars[index].name)
                                    .foregroundColor(Color.primary)
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                
                                Text(avatars[index].description)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 10))
                                    .fontWeight(.regular)
                            }
                            
                        }
                        
                    }
                }
                
                
                // Continue button
                Button {
                    dismiss()
                } label: {
                    Text("Continue with \(selectedAvatarName)")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.blackBtnText)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                }
                .background(Color.blackBtn)
                .cornerRadius(30)
                .padding(.bottom, 0)
                .padding()
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(.avatarBG)
        
        Spacer()
    }
}

#Preview {
    @State var avatarImage = UIImage(named: "avatar1")!
    return SelectAvatarView(selectedAvatarImage: $avatarImage)
}
