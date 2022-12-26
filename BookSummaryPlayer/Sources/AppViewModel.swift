//
//  AppViewModel.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class AppViewModel: ObservableObject {
    var playbackTime: Double { audioPlayer.currentTime }
    var playbackDuration: Double {
        get async throws { try await audioPlayer.currentAudioDuration }
    }
    
    func loadLocalBook() {
        guard let chapterURL = playerDataSource.source.chapters.first?.url else {
            return assertionFailure("Failed to get the audiofile URL.")
        }
        audioPlayer.configure(with: chapterURL)
    }
    
    func handleScreenClose() {
        debugPrint("Handle action to close the current screen.")
    }
    
    func handlePlaybackSpeed() {
        audioPlayer.setRate()
    }
    
    func handleSeekInterval(newValue: ContentViewModel.AudioReplayUpdate) {
        switch newValue {
        case .fiveSecondsBack:
            break //TODO: implement the case
        case .tenSecondsForward:
            break //TODO: implement the case
        case .custom(let seekInterval):
            break //TODO: implement the case
        }
    }
    
    func handleAudioReplace(newValue: ContentViewModel.TargetableAudio) {
        switch newValue {
        case .previous:
            break //TODO: implement the case
        case .next:
            break //TODO: implement the case
        }
    }
    
    func handleAudioState(isPlaying: Bool) {
        if isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    
    func handleSwitchBetweenAudioText(
        from: ContentViewModel.AudiobookRepresentation,
        to: ContentViewModel.AudiobookRepresentation
    ) {
        debugPrint("Handle switch from \(from.rawValue) representation to the \(to.rawValue).")
    }
    
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

private extension Audiofile {
    var url: URL? { Bundle.main.url(forResource: path, withExtension: fileExtension) }
}
