//
//  AudioPlayer.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import AVFoundation
import Foundation

final class AudioPlayer {
    var isPaused: Bool {
        player.rate.isEqual(to: 0)
    }
    
    var currentTime: Double {
        player.currentTime().seconds
    }
    
    var currentAudioDuration: Double {
        get async throws {
            try await currentAudioAsset?.load(.duration).seconds ?? 0
        }
    }
    
    func configure(with url: URL) {
        let asset = AVAsset(url: url)
        currentAudioAsset = asset
        player.replaceCurrentItem(with: AVPlayerItem(asset: asset))
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
    
    func setSeekInterval(_ interval: Double) {
        let seekTime = CMTime(seconds: interval, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: seekTime)
    }
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            debugPrint("Failed to set the category, mode for the shared AVAudioSession or set the session active.")
        }
        player.allowsExternalPlayback = true
    }
    
    private var player = AVPlayer()
    private weak var playerDelegate: AVAudioPlayerDelegate?
    private var currentAudioAsset: AVAsset? //check out `player.replaceCurrentItem(with:)` method when update the local asset
}
