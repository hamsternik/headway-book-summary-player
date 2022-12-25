//
//  AudioPlayerDataSource.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class AudioPlayerDataSource {
    init(source: any Audiobook) {
        self.source = source
    }
    
    private(set) var source: any Audiobook
}
