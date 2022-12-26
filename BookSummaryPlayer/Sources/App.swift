//
//  App.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 21.12.2022.
//

import SwiftUI

@main
struct BookSummaryPlayerApp: App {
    @ObservedObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(
                    playbackTime: viewModel.playbackTime,
                    audioRate: .standard, //TODO: 
                    onTapClose: viewModel.handleScreenClose,
                    onChangeSpeed: viewModel.handlePlaybackSpeed,
                    onChangeReplay: viewModel.handleSeekInterval,
                    onChangeAudio: viewModel.handleAudioReplace,
                    onPlayAudio: viewModel.handleAudioState,
                    onSwitchAudioAndTextView: viewModel.handleSwitchBetweenAudioText
                )
            )
            .onAppear {
                viewModel.loadLocalBook()
            }
        }
    }
}
