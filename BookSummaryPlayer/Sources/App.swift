//
//  App.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 21.12.2022.
//

import SwiftUI

@main
struct BookSummaryPlayerApp: App {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
