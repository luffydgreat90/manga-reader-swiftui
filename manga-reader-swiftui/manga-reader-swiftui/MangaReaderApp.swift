//
//  manga_reader_swiftuiApp.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 06/04/2025.
//

import SwiftUI

final class MangaReaderAppViewModel {
    private let baseURL: URL

    init(baseURL: URL = URL(string: "https://api.mangadex.org")!) {
        self.baseURL = baseURL
    }

    private lazy var urlSession: URLSessionProtocol = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    lazy var mangaService: MangaService = {
        MangaService(urlSession: urlSession,
                     baseURL: baseURL)
    }()

}

@main
struct MangaReaderApp: App {
    private let viewModel: MangaReaderAppViewModel

    init() {
        self.viewModel = MangaReaderAppViewModel()
    }

    private func openURL(url: URL?) {
        guard let url =  url else { return }
        UIApplication.shared.open(url)
    }

    var body: some Scene {
        WindowGroup {
            MangaListView(
                mangaService: viewModel.mangaService,
                openURL: openURL
            )
        }
    }
}
