//
//  AddNotesView.swift
//  PdfSpeaker
//
//  Created by r a a j on 01/11/2024.
//

import SwiftUI

struct AddNotesView: View {
    @FocusState private var isFocusedTitleTF: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State private var titleText: String = ""
    
    var body: some View {
        VStack {
            
            // top nav bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .frame(width: 25, height: 25)
                        .foregroundColor(.soundWave)
                        .padding(.leading, 20)
                }
                
                Spacer()
                
            }
            .overlay(
                Text("Add Notes")
                    .foregroundColor(.blackBtn)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
            )
            .padding(.top, 30)
            
            
            // title textfield
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.avatarBG)
    }
}

#Preview {
    AddNotesView()
}
