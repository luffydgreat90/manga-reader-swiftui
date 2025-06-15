//
//  manga_reader_swiftuiApp.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 06/04/2025.
//

import SwiftUI

@main
struct MangaReaderApp: App {
    @StateObject private var mangaService: MangaService

    init() {
        let urlSession = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let url = URL(string: "https://api.mangadex.org")!
        _mangaService = StateObject(wrappedValue: MangaService(urlSession: urlSession, baseURL: url))
    }

    private func openURL(url: URL?) {
        guard let url =  url else { return }
        UIApplication.shared.open(url)
    }

    var body: some Scene {
        WindowGroup {
            MangaListView(
                openURL: openURL
            ).environmentObject(mangaService)
        }
    }
}
