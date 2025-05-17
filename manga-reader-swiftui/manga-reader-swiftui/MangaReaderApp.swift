//
//  manga_reader_swiftuiApp.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 06/04/2025.
//

import SwiftUI

@main
struct MangaReaderApp: App {

    private let baseURL = URL(string: "https://api.mangadex.org")!

    private lazy var urlSession: URLSessionProtocol = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    private lazy var mangaService: MangaService = {
        MangaService(urlSession: urlSession,
                     baseURL: baseURL)
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
