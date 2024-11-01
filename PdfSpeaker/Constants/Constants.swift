//
//  Constants.swift
//  PdfSpeaker
//
//  Created by r a a j on 29/10/2024.
//

import SwiftUI


public var files: [LibraryListModel] = [
    LibraryListModel(image: UIImage(named: "pdf&More")!, name: "PDF More", date: "Oct 31", type: .file, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "scanText")!, name: "Scn Text", date: "Oct 31", type: .scannedFile, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "webLink")!, name: "Web nks", date: "Oct 31", type: .webLink, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "typeOrPasteText")!, name: "Type or ste text", date: "Oct 31", type: .textFile, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "webLink")!, name: "Web Lis", date: "Oct 31", type: .webLink, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "typeOrPasteText")!, name: " paste text", date: "Oct 31", type: .textFile, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "pdf&More")!, name: "PDF & re", date: "Oct 31", type: .file, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "scanText")!, name: "Scaext", date: "Oct 31", type: .scannedFile, duration: "10 s"),
    LibraryListModel(image: UIImage(named: "webLink")!, name: "Weinks", date: "Oct 31", type: .webLink, duration: "10 s"),
]

func formatTime(_ seconds: Double) -> String {
    let minutes = Int(seconds) / 60
    let seconds = Int(seconds) % 60
    
    return String(format: "%02d:%02d", minutes, seconds)
}

