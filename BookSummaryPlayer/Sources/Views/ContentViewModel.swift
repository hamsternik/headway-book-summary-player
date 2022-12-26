//
//  ContentViewModel.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

final class ContentViewModel: ObservableObject {
    enum TargetableAudio: Int, Hashable {
        case previous = -1, next = 1
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
    
    enum AudioRate: Float, Hashable {
        case standard = 1.0, oneAndHalf = 1.5, double = 2.0
        
        var next: AudioRate {
            switch self {
            case .standard: return .oneAndHalf
            case .oneAndHalf: return .double
            case .double: return .standard
            }
        }
    }
    
    init(
        playbackTime: Double,
        audioRate: AudioRate,
        onTapClose: @escaping () -> Void,
        onChangeSpeed: @escaping (AudioRate) -> Void,
        onChangeReplay: @escaping (_ to: AudioReplayUpdate) -> Void,
        onChangeAudio: @escaping (_ on: TargetableAudio) -> Void,
        onPlayAudio: @escaping (Bool) -> Void,
        onSwitchAudioAndTextView: @escaping (_ from: AudiobookRepresentation, _ to: AudiobookRepresentation) -> Void
    ) {
        self.playbackTime = playbackTime
        self.audioRate = audioRate
        self.onTapClose = onTapClose
        self.onChangeSpeed = onChangeSpeed
        self.onChangeReplay = onChangeReplay
        self.onChangeAudio = onChangeAudio
        self.onPlayAudio = onPlayAudio
        self.onSwitchAudioAndTextView = onSwitchAudioAndTextView
    }
    
    @Published private(set) var playbackTime: Double
    @Published var audioRate: AudioRate
    let onTapClose: () -> Void
    let onChangeSpeed: (AudioRate) -> Void
    let onChangeReplay: (_ to: AudioReplayUpdate) -> Void
    let onChangeAudio: (_ on: TargetableAudio) -> Void
    let onPlayAudio: (Bool) -> Void
    let onSwitchAudioAndTextView: (_ from: AudiobookRepresentation, _ to: AudiobookRepresentation) -> Void
}
