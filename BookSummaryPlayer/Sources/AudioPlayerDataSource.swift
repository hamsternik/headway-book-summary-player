//
//  BloodSweatAndPixelsBookDataSource.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class BloodSweatAndPixelsBookDataSource {
    var book: BloodSweatAndPixels
    var currentChapter: BloodSweatAndPixels.Chapter
    
    init(book: BloodSweatAndPixels, currentChapter: BloodSweatAndPixels.Chapter) {
        self.book = book
        self.currentChapter = currentChapter
    }
}
