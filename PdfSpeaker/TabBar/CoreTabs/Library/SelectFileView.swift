//
//  SelectFileView.swift
//  PdfSpeaker
//
//  Created by r a a j on 31/10/2024.
//

import SwiftUI

struct SelectFileView: View {
    
    @Binding var files: [LibraryListModel]
    
    let actions: [FileActionModel] = [
        FileActionModel(image: "square.and.arrow.down", name: "Download"),
        FileActionModel(image: "square.and.pencil", name: "Edit"),
        FileActionModel(image: "trash", name: "Delete"),
    ]
    
    let colors: [Color] = [.onboardingDarkGreen, .onboardingGray, .red]
    
    var body: some View {
        VStack {
                
            if #available(iOS 16.0, *) {
                List(actions.indices, id: \.self) { index in
                    HStack(alignment: .center) {
                        Image(systemName: actions[index].image)
                            .frame(width: 20, height: 20)
                            .padding(.leading, 30)
                            .foregroundColor(colors[index])
                        
                        Text(actions[index].name)
                            .foregroundColor(colors[index])
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .padding(.leading, 10)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.blackBtnText)
                    .border(.blackBtnText, width: 1)
                    .cornerRadius(25)
                    .onTapGesture {
                        handleActions(index: index)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.avatarBG)
    }
    
    
    private func handleActions(index: Int) {
        let action = actions[index].name
        switch action {
        case "Download":
            print("Download")
        case "Edit":
            print("Edit")
        case "Delete":
            if !files.isEmpty {
                files.remove(at: index)
                print("deleted \(files[index])")
            }
        default:
            print("nothing is happeing!!!")
        }
    }
    
}

#Preview {
    SelectFileView(files: .constant(files))
}
