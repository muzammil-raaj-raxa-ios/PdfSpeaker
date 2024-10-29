//
//  SettingModel.swift
//  PdfSpeaker
//
//  Created by r a a j on 28/10/2024.
//

import SwiftUI

struct SectionOneSettingModel: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
    let name: String
    let more: String
}


struct SectionTwoSettingModel: Identifiable, Hashable {
    let id = UUID()
    let image: UIImage
    let name: String
}
