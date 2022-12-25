//
//  AudioBook.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 25.12.2022.
//

import Foundation

protocol Audiobook: Hashable {
    associatedtype Chapter: Audiofile
    
    var chapters: [Chapter] { get }
}

protocol Audiofile: Identifiable, Hashable {
    var id: String { get }
    var path: String { get }
    var fileExtension: String { get }
}

extension Audiofile {
    var url: URL { URL(fileURLWithPath: path) }
}
