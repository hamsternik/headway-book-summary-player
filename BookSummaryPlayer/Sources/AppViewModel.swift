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
    private(set) var audioRate: ContentViewModel.AudioRate = .standard
    
    func loadLocalBook() {
        guard let chapterURL = playerDataSource.source.chapters.first?.url else {
            return assertionFailure("Failed to get the audiofile URL.")
        }
        audioPlayer.configure(with: chapterURL)
    }
    
    func handleScreenClose() {
        debugPrint("Handle action to close the current screen.")
    }
    
    func handlePlaybackSpeed(newValue: ContentViewModel.AudioRate) {
        audioRate = newValue
        guard !audioPlayer.isPaused else { return }
        audioPlayer.setRate(audioRate.rawValue)
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
            /// `setRate()` with the 1.0 value is equal to the `play()` method. Passing 0.0 rate is equal to `pause()`.
            audioPlayer.setRate(audioRate.rawValue)
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
