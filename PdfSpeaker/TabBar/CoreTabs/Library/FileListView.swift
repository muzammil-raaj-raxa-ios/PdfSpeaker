//
//  FileListView.swift
//  PdfSpeaker
//
//  Created by r a a j on 31/10/2024.
//

import SwiftUI

struct FileListView: View {
    @Binding var searchText: String
    
    var body: some View {
        if #available(iOS 16.0, *) {
            if files.count > 0 {
                FileContentView(searchText: $searchText, files: files)
            } else {
                EmptyContentView()
            }
            
            
            
        }
    }
}

#Preview {
//    FileListView()
}

struct FileContentView: View {
    @State private var showSelectFile: Bool = false
    @State private var selectedFileIndex: Int?
    
    
    @Binding var searchText: String
    
    let files: [LibraryListModel]
    
    var filteredFiles: [LibraryListModel] {
        files.filter { file in
            searchText.isEmpty || file.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack {
            if #available(iOS 16.0, *) {
                List(filteredFiles) { file in
                    HStack {
                        ZStack {
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .cornerRadius(15)
                                .foregroundColor(.blackBtnText)
                            
                            Image(uiImage: file.image)
                                .frame(width: 20, height: 30)
                        }
                        .padding(.leading, 15)
                        
                        VStack(spacing: 10) {
                            Text(file.name)
                                .foregroundColor(.blackBtn)
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 5) {
                                Text(file.date)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                
                                Text("•")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                
                                Text(file.type.rawValue)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                
                                Text("•")
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                
                                Text(file.duration)
                                    .foregroundColor(.onboardingGray)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.leading, 10)
                        
                        Button {
                            showSelectFile.toggle()
                        } label: {
                            VStack(spacing: 5) {
                                Circle()
                                    .frame(width: 4, height: 4)
                                    .foregroundColor(.blackBtn)
                                Circle()
                                    .frame(width: 4, height: 4)
                                    .foregroundColor(.blackBtn)
                                Circle()
                                    .frame(width: 4, height: 4)
                                    .foregroundColor(.blackBtn)
                            }
                            .padding(.trailing, 20)
                        }
                        
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .frame(height: 70)
                    .background(.onboardingCardGrey)
                    .cornerRadius(20)
                }
                .scrollContentBackground(.hidden)
            }
            
        }
        .sheet(isPresented: $showSelectFile) {
            if #available(iOS 16.0, *) {
                SelectFileView(files: .constant(files))
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(270)])
            }
        }
    }
}

struct EmptyContentView: View {
    var body: some View {
        VStack {
            Text("Nothing to Listen")
                .foregroundColor(.blackBtn)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            
            Text("Ready to your input")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 14))
                .fontWeight(.medium)
            
            Text("Let’s discover the next content!")
                .foregroundColor(.onboardingGray)
                .font(.system(size: 14))
                .fontWeight(.medium)
            
            // Next button
            Button {
                
            } label: {
                Text("Continue")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.blackBtnText)
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
            .background(Color.blackBtn)
            .cornerRadius(30)
            .padding(.top, 30)
            .padding([.leading, .trailing], 40)
        }
    }
}

