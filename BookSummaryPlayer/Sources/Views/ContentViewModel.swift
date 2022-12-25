//
//  ContentViewModel.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class ContentViewModel: ObservableObject {
    enum TargetableAudio: Hashable, CaseIterable {
        case previous, next
    }
    
    enum AudioReplayUpdate: Hashable {
        case fiveSecondsBack, tenSecondsForward, custom(Double)
    }
    
    enum AudiobookRepresentation: String, Hashable {
        case audio, text
        
        var previous: AudiobookRepresentation {
            switch self {
            case .audio: return .text
            case .text: return .audio
            }
        }
    }
    
    init(
        audioPlayer: AudioPlayer = AudioPlayer(),
        playerDataSource: AudioPlayerDataSource = AudioPlayerDataSource(source: BloodSweatAndPixels()),
        onTapClose: @escaping () -> Void,
        onChangeSpeed: @escaping () -> Void,
        onChangeReplay: @escaping (_ to: AudioReplayUpdate) -> Void,
        onChangeAudio: @escaping (_ on: TargetableAudio) -> Void,
        onPlayOrPauseAudio: @escaping () -> Void,
        onSwitchAudioAndTextView: @escaping (_ from: AudiobookRepresentation, _ to: AudiobookRepresentation) -> Void
    ) {
        self.audioPlayer = audioPlayer
        self.playerDataSource = playerDataSource
        self.onTapClose = onTapClose
        self.onChangeSpeed = onChangeSpeed
        self.onChangeReplay = onChangeReplay
        self.onChangeAudio = onChangeAudio
        self.onPlayOrPauseAudio = onPlayOrPauseAudio
        self.onSwitchAudioAndTextView = onSwitchAudioAndTextView
    }
    
    let audioPlayer: AudioPlayer
    let playerDataSource: AudioPlayerDataSource
    let onTapClose: () -> Void
    let onChangeSpeed: () -> Void
    let onChangeReplay: (_ to: AudioReplayUpdate) -> Void
    let onChangeAudio: (_ on: TargetableAudio) -> Void
    let onPlayOrPauseAudio: () -> Void
    let onSwitchAudioAndTextView: (_ from: AudiobookRepresentation, _ to: AudiobookRepresentation) -> Void
}
