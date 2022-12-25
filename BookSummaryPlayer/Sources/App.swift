//
//  App.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 21.12.2022.
//

import SwiftUI

@main
struct BookSummaryPlayerApp: App {
//    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(
                    onTapClose: handleTapClose,
                    onChangeSpeed: handleChangeSpeed,
                    onChangeReplay: handleChangeReplay,
                    onChangeAudio: handleChangeAudio,
                    onPlayOrPauseAudio: handlePlayPauseAudio,
                    onSwitchAudioAndTextView: handleSwitchBetweenAudioText
                )
            )
        }
    }
}

extension BookSummaryPlayerApp {
    private func handleTapClose() {
        debugPrint("Handle action to close the current screen.")
    }
    
    private func handleChangeSpeed() {
    }
    
    private func handleChangeReplay(newValue: ContentViewModel.AudioReplayUpdate) {
    }
    
    private func handleChangeAudio(newValue: ContentViewModel.TargetableAudio) {
    }
    
    private func handlePlayPauseAudio() {
    }
    
    private func handleSwitchBetweenAudioText(
        from: ContentViewModel.AudiobookRepresentation,
        to: ContentViewModel.AudiobookRepresentation
    ) {
        debugPrint("Handle switch from \(from.rawValue) representation to the \(to.rawValue).")
    }
}
