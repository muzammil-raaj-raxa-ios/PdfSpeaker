//
//  LibraryView.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct LibraryView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                VStack(spacing: 0) {
                    NavBarView(searchText: $searchText)
                        .padding(.bottom, 10)
                    
                    if files.count > 0 {
                        CategoryButtonView()
                            .padding(.bottom, 0)
                    }
                    
                    Spacer()
                    
                    FileListView(searchText: $searchText)
                        .padding(.top, 0)
                    
                    
                    Spacer()
                }
                
                
            }
        }
    }
}

#Preview {
    LibraryView()
}

