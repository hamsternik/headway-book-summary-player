//
//  AudioPlayer.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation
import AVFoundation

final class AudioPlayer {
    static let shared = AudioPlayer()
    
    private var player = AVPlayer()
    private weak var playerDelegate: AVAudioPlayerDelegate?
    private var currentAudioAsset: AVAsset? //check out `player.replaceCurrentItem(with:)` method when update the local asset
    
    func configure(with url: URL) {
        currentAudioAsset = AVAsset(url: url)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            debugPrint("Failed to set the category, mode for the shared AVAudioSession or set the session active.")
        }
        player.allowsExternalPlayback = true
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func setRate(_ rate: Float = 1.0) {
        player.rate = rate
    }
    
    var currentTime: Double {
        player.currentTime().seconds
    }
    
    var currentAudioDuration: Double {
        get async throws {
            try await currentAudioAsset?.load(.duration).seconds ?? 0
        }
    }
}