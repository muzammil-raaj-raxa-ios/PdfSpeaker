//
//  AvatarModel.swift
//  PdfSpeaker
//
//  Created by Raaj's mac mini on 25/10/2024.
//

import SwiftUI

struct AvatarModel: Identifiable {
    let id = UUID()
    let image: UIImage
    let name: String
    let description: String
}
