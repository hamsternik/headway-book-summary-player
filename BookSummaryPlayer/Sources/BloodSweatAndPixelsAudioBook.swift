//
//  BloodSweatAndPixelsAudioBook.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

struct BloodSweatAndPixels: Audiobook {
    struct Chapter: Audiofile {
        let id: String
        let fileExtension: String = "mp3"
        var path: String { id }
    }
    
    let chapters = [
        Chapter(id: "00_Para slov ot perevodchika"),
        Chapter(id: "01_Pillars of Eternity"),
        Chapter(id: "02_Uncharted 4"),
        Chapter(id: "03_Stardew Valley"),
        Chapter(id: "04_Diablo III"),
        Chapter(id: "05_Halo Wars"),
        Chapter(id: "06_Dragon Age- Inquisition"),
        Chapter(id: "07_Shovel Knight"),
        Chapter(id: "08_Destiny"),
        Chapter(id: "09_The Witcher 3"),
        Chapter(id: "10_Star Wars 1313"),
        Chapter(id: "11_Epilog")
    ]
}
