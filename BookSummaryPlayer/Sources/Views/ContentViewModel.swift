//
//  ContentViewModel.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class ContentViewModel: ObservableObject {
    init(
        audioPlayer: AudioPlayer = AudioPlayer(),
        playerDataSource: AudioPlayerDataSource = AudioPlayerDataSource(source: BloodSweatAndPixels())
        
    ) {
        self.audioPlayer = audioPlayer
        self.playerDataSource = playerDataSource
    }
    
    private let audioPlayer: AudioPlayer
    private let playerDataSource: AudioPlayerDataSource
}
