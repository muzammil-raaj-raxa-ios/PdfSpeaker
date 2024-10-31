//
//  LibraryListModel.swift
//  PdfSpeaker
//
//  Created by r a a j on 31/10/2024.
//


import SwiftUI

public struct LibraryListModel: Identifiable {
    public let id = UUID()
    let image: UIImage
    let name: String
    let date: String
    let type: FileType
    let duration: String
}

enum FileType: String {
    case file = "File"
    case scannedFile = "Scanned File"
    case webLink = "Web Link"
    case textFile = "Text File"
}
