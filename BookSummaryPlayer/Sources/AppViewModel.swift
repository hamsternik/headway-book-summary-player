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
    @Published private(set) var currentChapterIndex: Int = 0
    
    func onAppear() {
        configureAudioPlayer(with: dataSource.currentChapter.url)
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
        guard let currentIdx = dataSource.book.chapters.firstIndex(of: dataSource.currentChapter) else {
            return assertionFailure("Failed to get index of the current chapter from the data source.")
        }
        let distance = dataSource.book.chapters.distance(from: dataSource.book.chapters.startIndex, to: currentIdx)
        
        let newIndex = distance + newValue.rawValue
        switch newValue {
        case .previous:
            guard newIndex >= 0 else { return }
        case .next:
            guard newIndex < dataSource.book.chapters.count else { return }
        }
        
        currentChapterIndex = newIndex
        let newChapter = dataSource.book.chapters[newIndex]
        dataSource.currentChapter = newChapter
        configureAudioPlayer(with: newChapter.url)
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
        dataSource: BloodSweatAndPixelsBookDataSource = BloodSweatAndPixelsBookDataSource(
            book: BloodSweatAndPixels(), currentChapter: BloodSweatAndPixels().chapters.first!
        )
    ) {
        self.audioPlayer = audioPlayer
        self.dataSource = dataSource
    }
    
    private let audioPlayer: AudioPlayer
    private let dataSource: BloodSweatAndPixelsBookDataSource
    
    private func configureAudioPlayer(with assetURL: URL?) {
        guard let url = assetURL else {
            return assertionFailure("Failed to get the audiofile URL.")
        }
        audioPlayer.configure(with: url)
    }
}

private extension Audiofile {
    var url: URL? { Bundle.main.url(forResource: path, withExtension: fileExtension) }
}
